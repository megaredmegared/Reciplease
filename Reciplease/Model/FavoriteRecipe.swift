
import Foundation
import CoreData

/// Favorites recipes stored on the phone
class FavoriteRecipe: NSManagedObject {
    
    // MARK: - Variables
    static var all: [FavoriteRecipe] {
        let storageManager = StorageManager()
        return storageManager.fetchAllFavoritesRecipes()
    }
}

// MARK: - Extension

extension FavoriteRecipe {
    
    /// Transform Favorite Recipe in Recipe
    static func transformFavoriteRecipeInRecipe(_ favoriteRecipe: FavoriteRecipe) -> Recipe? {
        var recipe = Recipe()
        var ingredients = [IngredientAPI]()
        
        for text in favoriteRecipe.ingredients ?? [String]() {
            let ingredient = IngredientAPI(text: text)
            ingredients.append(ingredient)
        }
        
        recipe.label = favoriteRecipe.name
        recipe.ingredients = ingredients
        recipe.shareAs = favoriteRecipe.shareAs
        recipe.uri = favoriteRecipe.uri
        recipe.url = favoriteRecipe.url
        recipe.totalTime = favoriteRecipe.time
        
        return recipe
    }
}


