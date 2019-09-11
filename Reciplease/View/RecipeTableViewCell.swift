//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by megared on 11/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(image: UIImage?, recipe: String, ingredients: String) {
        if image != nil {
            recipeImage.image = image
        }
        recipeTitle.text = recipe
        ingredientTitle.text = ingredients
    }

}
