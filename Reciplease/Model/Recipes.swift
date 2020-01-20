
import Foundation

/// Recipes object: list of recipes
struct Recipes: Codable {
    var from: Int? = 0
    var to: Int?
    var count: Int?
    var hits: [Hit]?
}

extension Recipes {
    /// function to add recipes to the list
    mutating func addRecipes(numberOfRecipesLoaded: Int,
                             recipesResponse: Recipes?,
                             numberOfRecipesToFetch: Int) {
        
        self.from = numberOfRecipesLoaded
        self.to = (numberOfRecipesLoaded) + (numberOfRecipesToFetch)

        // add new fetched recipes
        if let hits  = recipesResponse?.hits {
            self.hits?.append(contentsOf: hits)
        }
        
        // fetch the total existing recipes
        self.count = recipesResponse?.count ?? self.count
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
    func isFavorite(favoritesRecipes: [FavoriteRecipe] = FavoriteRecipe.all) -> Bool {
        
        if favoritesRecipes.contains(where: {$0.uri == uri}) {
            return true
        }
        return false
    }
}

struct IngredientAPI: Codable {
    var text: String?
}




