
import Foundation
import CoreData

/// The ingredients objects used for the recipe search
class Ingredient: NSManagedObject {
    
    /// fetch all ingredients
    static var all: [Ingredient] {
        let storageManager = StorageManager()
        return storageManager.fetchAllIngredients()
    }
    
    /// remove ingredients that are already listed
    static func removeAlreadylistedIngredient(ingredientsNamesList: [String], ingredients: [Ingredient] = Ingredient.all) -> [String] {
        ingredientsNamesList.filter { ingredientName in
            !ingredients.contains { $0.name == ingredientName }
        }
    } 
}

