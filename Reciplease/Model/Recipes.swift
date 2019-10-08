//
//  Recipe.swift
//  Reciplease
//
//  Created by megared on 05/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

struct Recipes: Codable {
    
    var from: Int = 0
    var to: Int = 0
    var more: Bool = false
    var count: Int = 0
    
    var hits: [Hit] = []
    
    struct Hit: Codable {
        var recipe: Recipe = Recipe()
        
        struct Recipe: Codable {
            var label: String = ""
            var image: String = ""
            var uri: String = ""
            var url: String = ""
            var shareAs: String = ""
            var ingredientLines: [String] = []
            var ingredients: [Ingredient] = []
            
            struct Ingredient: Codable {
                var text: String = ""
                var food: String = ""
            }
        }
    }
}


extension Recipes.Hit.Recipe {
    
    /// Check if a recipe is already marked as favorite
    var isFavorite: Bool {
        
    if FavoriteRecipe.all.contains(where: {$0.uri == uri}) {
            return true
        } else {
            return false
        }
    }

}
