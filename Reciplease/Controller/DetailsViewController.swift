
import UIKit
import Kingfisher
import SafariServices

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var starFavorite: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK: - Variables
    
    var recipe: Recipe?
    var favoritesRecipes: [FavoriteRecipe] { FavoriteRecipe.all }
    var image: UIImage?
    var imageThumbnail: UIImage?
    
    let storageManager = StorageManager()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   // add logo to navigation bar
        navigationItem.titleView = UIImageView.init(image: .logoReciplease)
        showDetails()
    }
    
    // MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            // Make by default the list scrolled to the top
            ingredientsList.setContentOffset(.zero, animated: false)
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         updateStarButton()
    }
    
    //MARK: - Functions
    
    /// Update star Button
    private func updateStarButton() {
        if recipe?.isFavorite == true {
            starFavorite.image = .starFilled
        } else {
            starFavorite.image = .starEmpty
        }
    }
    
    /// add or delete from favorite
    private func addOrDeleteFavorite() {
        if recipe?.isFavorite == false {
            addFavorite()
        } else {
            deleteFavorite()
        }
    }
    
    /// add favorite
    private func addFavorite() {
        guard let recipe = recipe else {
            return
        }
        let imageOK = image?.pngData() ?? UIImage.placeholderImage.pngData()!
        let thumbnail = imageThumbnail?.pngData() ?? UIImage.placeholderImage.pngData()!
        
        storageManager.insertFavoriteRecipe(recipe, image: imageOK, thumbnail: thumbnail, save: true)

        updateStarButton()
    }
    
    /// delete favorite
    private func deleteFavorite() {
        let recipeURI = recipe?.uri
        for recipe in favoritesRecipes where recipe.uri == recipeURI {
            storageManager.remove(objectID: recipe.objectID, save: true)
        }
        updateStarButton()
    }
    
    // MARK: - View
    // Update the view with infos of the recipe
    private func showDetails() {
        
        recipeImage.image = image
        recipeTitle.text = recipe?.label
        
        if let time = recipe?.totalTime {
            timeLabel.text = Recipe.formatedTime(time: time)
        }
        
        var ingredientText: String? {
            guard let ingredientsLines = recipe?.ingredients?.compactMap({($0.text)}) else {
                return nil
            }
            return ingredientsLines
                .map({"- " + $0})
                .joined(separator: ",\n\n")
                .appending(".")
        }
        
        ingredientsList.text = ingredientText
    }
    
    // MARK: - Actions
    
    @IBAction func triggerStarButton(_ sender: Any) {
        addOrDeleteFavorite()
    }
}

// MARK: - Navigation

extension DetailsViewController: SFSafariViewControllerDelegate {
    
    private func openSafariVC() {
        let stringURL = recipe?.shareAs ?? ""
        let recipeURL = URL(string: stringURL)
        let safariVC = SFSafariViewController(url: recipeURL!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.preferredControlTintColor = .black
        safariVC.preferredBarTintColor = .mainColor
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func triggerGetDirectionButton(_ sender: Any) {
        openSafariVC()
    }
    
}
