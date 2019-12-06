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
        guard let time = time else {
            return nil
        }
        
        if time == 0 {
            return nil
        } else if (1..<60).contains(time) {
            return String(Int(time)) + "m"
        } else if time == 60 {
            let hours = time / 60
            return String(Int(hours)) + "h"
        } else {
            let hours = time / 60
            let minutes = time.truncatingRemainder(dividingBy: 60)
            return String(Int(hours)) + "h" + String(Int(minutes)) + "m"
        }
    }
}

struct IngredientAPI: Codable {
    var text: String?
}




