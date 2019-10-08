//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by megared on 13/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    
    var originalImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Favorites tableView
    
    /// Configure cell for favorite tableView
    func favoriteConfigureWith(recipe: String, ingredients: String, imageThumbnail: UIImage?) {
        recipeImage.image = imageThumbnail
        recipeTitle.text = recipe
        ingredientTitle.text = ingredients
    }
    
    //MARK: - Search tableView
    
    /// Configure cell for search tableView
    func searchConfigureWith(imageUrl: URL?, recipe: String, ingredients: String) {
        
        recipeTitle.text = recipe
        ingredientTitle.text = ingredients
        
        // fetch and cache images with Kingfisher
        let placeholder = UIImage(named: "ingredients")
        let processorThumbnail = DownsamplingImageProcessor(size: CGSize(width: 70, height: 70))
            >> RoundCornerImageProcessor(cornerRadius: 35)
        
        recipeImage.kf.setImage(with: imageUrl,
                                placeholder: placeholder,
                                options: [
                                    .processor(processorThumbnail),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage,
                                    .transition(.fade(1))])
       
        KingfisherManager.shared.retrieveImage(with: imageUrl!) { result in
            switch result {
            case .success(let value):
                self.originalImage = value.image
            case .failure(let error):
                print(error)
            }
        }
    }
}
