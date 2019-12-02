//
//  Recipe.swift
//  Reciplease
//
//  Created by megared on 05/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

struct Recipes: Codable {
    var from: Int?
    var to: Int?
    var count: Int?
    var hits: [Hit]?
}

extension Recipes {
    mutating func addRecipes(numberOfRecipesLoaded: Int?, numberOfRecipesToFetch: Int, recipesResponse: Recipes) {

        // set the next range of recipes to fetch
        self.from = numberOfRecipesLoaded
        self.to = (self.from ?? 0) + (numberOfRecipesToFetch)
        
        // add new fetched recipes
        self.hits?.append(contentsOf: recipesResponse.hits ?? [])
        
        // fetch the total existing recipes
        self.count = recipesResponse.count
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
//    var ingredientLines: [String]?
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
    
    ///format Time minute Double to a String in hours and minutes
    static func formatedTime(time: Double?) -> String? {
        guard let timeOk = time else {
            return nil
        }
        if timeOk == 0 {
            return nil
        } else if (1..<60).contains(timeOk) {
            return String(Int(timeOk)) + "m"
        } else if timeOk == 60 {
            let hours = timeOk / 60
            return String(Int(hours)) + "h"
        } else {
            let hours = timeOk / 60
            let minutes = timeOk.truncatingRemainder(dividingBy: 60)
            return String(Int(hours)) + "h" + String(Int(minutes)) + "m"
        }
    }
}

struct IngredientAPI: Codable {
    var text: String?
}

extension IngredientAPI {
    /// List the names of ingredients in array
    static func listIngredientsLines(ingredients: [IngredientAPI]?) -> [String]? {
        guard let ingredients = ingredients else {
            return nil
        }
        
        var ingredientsLines = [String]()
        for ingredient in ingredients {
            if let ingredientLine = ingredient.text {
                ingredientsLines.append(ingredientLine)
            }
        }
        if ingredientsLines == [] {
            return nil
        } else {
            return ingredientsLines
        }
    }
}



