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
    
    var originalIMage: UIImageView!
    
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
    func favoriteConfigureWith(recipe: String, ingredients: String) {
        recipeImage.image = UIImage(named: "ingredients")
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
        let processorOrginal = DownsamplingImageProcessor(size: CGSize(width: 300, height: 300))
        
        recipeImage.kf.setImage(with: imageUrl,
                                placeholder: placeholder,
                                options: [
                                    .processor(processorThumbnail),
                                    .scaleFactor(UIScreen.main.scale),
                                    .cacheOriginalImage,
                                    .transition(.fade(1))])
        
        originalIMage?.kf.setImage(with: imageUrl,
                                   options: [
                                    .processor(processorOrginal),
                                    .scaleFactor(UIScreen.main.scale)])
    }
    
}
