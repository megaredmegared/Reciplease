
import UIKit

class RecipesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadMoreButton: UIButton!
    
    // MARK: - Variables
    
    let identities = ["", ""]
    var ingredients = Ingredient.all
    var recipes = Recipes()
    var images = [UIImage?]()
    
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
        let numberOfRecipesLoaded = recipes.hits.count
        let totalRecipes = recipes.count
        if numberOfRecipesLoaded < totalRecipes {
            loadMoreButton.setTitle("\(numberOfRecipesLoaded)/\(totalRecipes) + load more recipes...", for: .normal)
        } else if numberOfRecipesLoaded >= totalRecipes {
            loadMoreButton.setTitle("All \(totalRecipes) recipes are loaded !", for: .disabled)
            print(numberOfRecipesLoaded)
            print(totalRecipes)
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
        return self.recipes.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .recipesCell, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = self.recipes.hits[indexPath.row]
        let recipeName = recipe.recipe.label
        
        // Fill all the ingredients names in one ingredientsNames String
        let ingredients = recipe.recipe.ingredients
//        let ingredientsNames = Ingredient.listIngredients(ingredients: ingredients)
        let ingredientsNames = Ingredient.listNames(ingredients: ingredients)?.formatListNames()
        
        // Load image
        let imageStringURL = recipe.recipe.image
        let imageUrl: URL? = URL(string: imageStringURL)
        
        // Fill time
        let time = recipe.recipe.totalTime
        let formatedTime = Recipe.formatedTime(time: time)
        
        cell.searchConfigureWith(imageUrl: imageUrl,
                                 recipe: recipeName,
                                 ingredients: ingredientsNames ?? "no ingredients found",
                                 time: formatedTime)
        
        return cell
    }
    
    // MARK: - Search recipes
    
    private func searchRecipes() {
        
        let recipesLoaded = self.recipes.hits.count
        let numberOfRecipesToFetch = 20
        
        APIClient.search(numberOfRecipesToFetch: numberOfRecipesToFetch, recipes: recipes, ingredients: ingredients) { response in
            
            switch response.result {
                
            case .success:
                
                guard let recipesResponse = response.value else {
                    return
                }
                
                // set the next range of recipes to fetch
                self.recipes.from = recipesLoaded
                self.recipes.to = self.recipes.from + numberOfRecipesToFetch
                // add new fetched recipes
                self.recipes.hits += recipesResponse.hits
                // fetch the total existing recipes
                self.recipes.count = recipesResponse.count
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
        hide(button: true, activity: false)
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
        let recipe = self.recipes.hits[selectedRowIndex].recipe
        
        let imageThumbnail = selectedCell.recipeImage.image
        let image = selectedCell.originalImage
        
        let details = segue.destination as! DetailsViewController
        
        details.recipe = recipe
        details.imageThumbnail = imageThumbnail
        details.image = image
        
    }
    
}
