
import UIKit
import Kingfisher

class RecipesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    
    // MARK: - Variables
    
    var originalImage: UIImage?
    
    //MARK: - Search tableView
    
    /// Configure cell for search tableView
    func searchConfigureWith(imageUrl: URL?, recipe: String, ingredients: String) {
        
        recipeTitle.text = recipe
        ingredientTitle.text = ingredients
        
        // fetch and cache images with Kingfisher
        let placeholder = UIImage.placeholderImage
        let processorThumbnail = DownsamplingImageProcessor(size: CGSize(width: 70, height: 70))
            >> RoundCornerImageProcessor(cornerRadius: 35)
        
        recipeImage.kf.setImage(with: imageUrl,
                                placeholder: placeholder,
                                options: [
                                    .processor(processorThumbnail),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage,
                                    .transition(.fade(1))])
        
        guard let url = imageUrl else { return }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                self.originalImage = value.image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Favorites tableView
    
    /// Configure cell for favorite tableView
    func favoriteConfigureWith(recipe: String, ingredients: String, imageThumbnail: UIImage?) {
        recipeImage.image = imageThumbnail
        recipeTitle.text = recipe
        ingredientTitle.text = ingredients
    }
    
}
