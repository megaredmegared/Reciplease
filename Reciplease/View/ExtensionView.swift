
import Foundation
import UIKit

extension String {
    /// Cell identifier for ingredient
    static let ingredientCell = "IngredientCell"
    /// Cell identifier for custom cell RecipesTableViewCell
    static let recipesTableViewCell = "RecipesTableViewCell"
    /// Cell identifier for custom cell
    static let recipesCell = "RecipesCell"
    /// Segue identifier search result to detailsView
    static let segueRecipeDetails = "SegueRecipeDetails"
    /// Segue identifier from favorite to detailsView
    static let segueFavoritesDetails = "SegueFavoritesDetails"
}

extension UIImage {
    static let placeholderImage = UIImage(named: "ingredients")!
    static let logoReciplease = UIImage(named: "logoReciplease")!
    /// Star image that is filled when recipe is in favorite
    static let starFilled = UIImage(named: "starFilled")!
    /// Star image that is empty when recipe is not in favorite
    static let starEmpty = UIImage(named: "starEmpty")!
}

extension UIColor {
    static let mainColor = UIColor(named: "MainColor")
    static let contrastMainColor = UIColor(named: "ContrastMainColor")
    static let secondColor = UIColor(named: "SecondColor")
    static let contrastSecondColor = UIColor(named: "ContrastSecondColor")
}

extension Data {
    var image: UIImage? {
        UIImage(data: self)
    }
}
