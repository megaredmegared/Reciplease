
import UIKit

class RecipesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadMoreButton: UIButton!
    
    // MARK: - Variables
    
    let identities = ["", ""]
    var ingredients = Ingredient.all
//    var recipes = Recipes(from: 0, to: 0, count: 0, hits: [Hit]())
    var recipes: Recipes?
    var images: UIImage?
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRecipes()
        
        // add logo to navigation bar
        navigationItem.titleView = UIImageView.init(image: .logoReciplease)
        
        // Set the custom tableViewCell for the favoritesTableView
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    // MARK: - Functions
    
    /// Toggle the loadMoreButton and/or the activity indicator
    private func hide(button: Bool, activity: Bool) {
        loadMoreButton.isHidden = button
        self.activityIndicator.isHidden = activity
    }
    
    /// Update the text of the loadMoreButton
    private func updateLoadButton() {
        let numberOfRecipesLoaded = recipes?.hits?.count ?? 0
        let totalRecipes = recipes?.count ?? 0
        if numberOfRecipesLoaded < totalRecipes {
            loadMoreButton.setTitle("\(numberOfRecipesLoaded) recipes + load more recipes...", for: .normal)
        } else {
            loadMoreButton.setTitle("All \(String(numberOfRecipesLoaded)) recipes are loaded !", for: .disabled)
            loadMoreButton.isEnabled = false
        }
    }
}

// MARK: - TableView list of search results of recipes

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .recipesCell, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let hit = self.recipes?.hits?[indexPath.row]
        let recipeName = hit?.recipe?.label
        
        // Fill all the ingredients names in one ingredientsNames String
        let ingredients = hit?.recipe?.ingredients
        let ingredientsLines = ingredients?.compactMap({$0.text}).formatListNames()
        
        // Load image
        let imageStringURL = hit?.recipe?.image ?? "no Image URL"
        let imageUrl: URL? = URL(string: imageStringURL)
        
        // Fill time
        let time = hit?.recipe?.totalTime
        let formatedTime = Recipe.formatedTime(time: time)
        
        cell.searchConfigureWith(imageUrl: imageUrl,
                                 recipe: recipeName,
                                 ingredients: ingredientsLines,
                                 time: formatedTime)
        
        return cell
    }
    
    // MARK: - Search recipes
    
    private func searchRecipes() {
        let numberOfRecipesLoaded = self.recipes?.hits?.count
        let numberOfRecipesToFetch = 2
        hide(button: true, activity: false)

        let apiClient = APIClient()
        apiClient.search(from: recipes?.to, numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients) { response in
            
            switch response.result {
                
            case .success:
                
                guard let recipesResponse = response.value else {
                    return
                }

                // add recipes
                if self.recipes == nil {
                    self.recipes = Recipes(from: 0, to: numberOfRecipesToFetch, count: 0, hits: [Hit]())
                }
                self.recipes?.addRecipes(numberOfRecipesLoaded: numberOfRecipesLoaded,
                                         recipesResponse: recipesResponse, numberOfRecipesToFetch: numberOfRecipesToFetch)
                
                // update the tableView with the new datas
                self.tableView.reloadData()
                self.updateLoadButton()
                self.hide(button: false, activity: true)
                
            case let .failure(error):
                print("""
                    debug error:
                    \(error)
                    """)
            }
        }
    }    
}

// MARK: - Actions

extension RecipesViewController {
    
    @IBAction func moreRecipes() {
        searchRecipes()
    }
    
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: .segueRecipeDetails, sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard
            let selectedCell = sender as? RecipesTableViewCell,
            let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == .segueRecipeDetails
            else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        // Pass the selected recipe to the DetailsViewController
        let recipe = self.recipes?.hits?[selectedRowIndex].recipe
        
        let imageThumbnail = selectedCell.recipeImage.image
        let image = selectedCell.originalImage
        
        let details = segue.destination as! DetailsViewController
        
        details.recipe = recipe
        details.imageThumbnail = imageThumbnail
        details.image = image
        
    }
    
}
