
import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var howToAddFavoriteMessage: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: - Variables
    
    var favoritesRecipes: [FavoriteRecipe] { FavoriteRecipe.all }
    
    let storageManager = StorageManager()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add logo to navigation bar
        navigationItem.titleView = UIImageView.init(image: .logoReciplease)
        
        // Set the custom tableViewCell for the favoritesTableView
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        favoritesTableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
    }
    
    // MARK: - Functions
    
    /// Animate the appearance of howToAddFavoriteMessage label
    private func animateHiddenView(_ view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    /// Check if the list of favorite is empty then show a message on how to had favorites
    private func showHowToAddFavoriteMessage() {
        if favoritesRecipes.isEmpty {
            animateHiddenView(howToAddFavoriteMessage, hidden: false)
            favoritesTableView.isHidden = true
        } else {
            howToAddFavoriteMessage.isHidden = true
            favoritesTableView.isHidden = false
        }
    }
}

// MARK: - TableView list of favorites recipes

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritesRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .recipesCell, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let favoriteRecipe = self.favoritesRecipes[indexPath.row]
        let name = favoriteRecipe.name
        let ingredients = favoriteRecipe.ingredients
        
        let defaultImageThumbnail = UIImage.placeholderImage.pngData()
        
        let imageThumbnail = UIImage(data: favoriteRecipe.imageThumbnail ?? defaultImageThumbnail!)
        
        let ingredientsLines = ingredients?.formatListNames()
        
        // Fill time
        let time = favoriteRecipe.time.formatTime()
        
        cell.favoriteConfigureWith(recipe: name,
                                   ingredients: ingredientsLines,
                                   imageThumbnail: imageThumbnail,
                                   time: time)
        
        return cell
    }
    
    // Enable swipe-to-delete feature
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteRecipe = favoritesRecipes[indexPath.row]
            storageManager.remove(objectID: favoriteRecipe.objectID, save: true)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
        showHowToAddFavoriteMessage()
    }
    
    /// Clear the list of favorites recipes
    @IBAction func clearButtonTapped(_ sender: Any) {
        for favoriteRecipe in favoritesRecipes {
            storageManager.remove(objectID: favoriteRecipe.objectID, save: true)
        }
        
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
    }
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.favoritesTableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: .segueFavoritesDetails, sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard
            let selectedCell = sender as? UITableViewCell,
            let selectedRowIndex = favoritesTableView.indexPath(for: selectedCell)?.row, segue.identifier == .segueFavoritesDetails
            else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        // Pass the selected recipe to the DetailsViewController
        let favoriteRecipe = favoritesRecipes[selectedRowIndex]
        
        // transform favorite recipe in the same recipe structure so we use only one DetailsView
        let recipe = FavoriteRecipe.transformFavoriteRecipeInRecipe(favoriteRecipe)
        
        let details = segue.destination as! DetailsViewController
        details.recipe = recipe
        // FIXME: Optional????
        details.imageThumbnail = favoriteRecipe.imageThumbnail?.image ?? UIImage.placeholderImage
        details.image = favoriteRecipe.image?.image ?? UIImage.placeholderImage
        
    }
    
}



