
import Foundation
import UIKit

extension String {
    
    /// Cell identifier for ingredient
    static let ingredientCell = "IngredientCell"
    /// Cell identifier for recipes
    static let recipesTableViewCell = "RecipesTableViewCell"
    /// Cell
    static let recipesCell = "RecipesCell"
    static let recipeDetails = "RecipeDetails"
    static let favoritesDetails = "FavoritesDetails"
    
    
}

extension UIImage {
    static let placeholderImage = UIImage(named: "ingredients")!
    static let logoReciplease = UIImage(named: "logoReciplease")!
    /// Star image that is filled when recipe is in favorite
    static let starFilled = UIImage(named: "starFilled")!
    static let starEmpty = UIImage(named: "starEmpty")!
}

extension UIColor {
    static let mainColor = UIColor(named: "MainColor")
    static let contrastMainColor = UIColor(named: "ContrastMainColor")
    static let secondColor = UIColor(named: "SecondColor")
    static let contrastSecondColor = UIColor(named: "ContrastSecondColor")
}
