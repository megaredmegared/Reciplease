
import Foundation

/// Recipes object: list of recipes
struct Recipes: Codable {
    var from: Int?
    var to: Int?
    var count: Int?
    var hits: [Hit]?
}

extension Recipes {
    mutating func addRecipes(numberOfRecipesLoaded: Int?, recipesResponse: Recipes?, numberOfRecipesToFetch: Int) {

        self.from = numberOfRecipesLoaded
        self.to = (self.from ?? 0) + (numberOfRecipesToFetch)
        
        // add new fetched recipes
        self.hits?.append(contentsOf: recipesResponse?.hits ?? [])
        
        // fetch the total existing recipes
        self.count = recipesResponse?.count
    }
}

struct Hit: Codable {
    var recipe: Recipe?
}

struct Recipe: Codable {
    var label: String?
    var image: String?
    var uri: String?
    var url: String?
    var shareAs: String?
    var ingredients: [IngredientAPI]?
    var totalTime: Double?
}

extension Recipe {
    
    /// Check if a recipe is already marked as favorite
    var isFavorite: Bool {
        
        if FavoriteRecipe.all.contains(where: {$0.uri == uri}) {
            return true
        } else {
            return false
        }
    }
}

struct IngredientAPI: Codable {
    var text: String?
}




