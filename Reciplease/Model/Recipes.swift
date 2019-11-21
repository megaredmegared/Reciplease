//
//  Recipe.swift
//  Reciplease
//
//  Created by megared on 05/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()

//struct Recipes: Codable {
//
//    var from: Int = 0
//    var to: Int = 0
//    var more: Bool = false
//    var count: Int = 0
//    var hits: [Hit] = []
//
//    struct Hit: Codable {
//        var recipe: Recipe = Recipe()
//
//
//
//        struct Recipe: Codable {
//            var label: String = ""
//            var image: String = ""
//            var uri: String = ""
//            var url: String = ""
//            var shareAs: String = ""
//            var ingredientLines: [String] = []
//            var ingredients: [Ingredient] = []
//
//            struct Ingredient: Codable {
//                var food: String = ""
//            }
//        }
//    }
//}

// MARK: - Recipes

struct Recipes: Codable {
    
    var from: Int
    var to: Int
    var more: Bool
    var count: Int
    var hits: [Hit]
    
    private enum RecipesCodingKeys: String, CodingKey {
        case from
        case to
        case more
        case count
        case hits
    }
    
    init() {
        self.from = 0
        self.to = 0
        self.more = false
        self.count = 0
        self.hits = [Hit]()
    }
    
    init(fromDecoder decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RecipesCodingKeys.self)
        from = try container.decodeIfPresent(Int.self, forKey: .from) ?? 0
        to = try container.decodeIfPresent(Int.self, forKey: .from) ?? 0
        more = try container.decodeIfPresent(Bool.self, forKey: .from) ?? false
        count = try container.decodeIfPresent(Int.self, forKey: .from) ?? 0
        hits = try container.decodeIfPresent([Hit].self, forKey: .from) ?? [Hit()]
    }

}

// MARK: - Hit

struct Hit: Codable {
    var recipe: Recipe
    
    private enum HitCodingKeys: String, CodingKey {
        case recipe
    }
    
    init() {
        self.recipe = Recipe()
    }
    
//    init(recipe: Recipe) {
//        self.recipe = recipe
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HitCodingKeys.self)
        recipe = try container.decodeIfPresent(Recipe.self, forKey: .recipe) ?? Recipe()
    }
}

// MARK: - Recipe

struct Recipe: Codable {
    var label: String
    var image: String
    var uri: String
    var url: String
    var shareAs: String
    var ingredientLines: [String]
    var ingredients: [IngredientAPI]
    var totalTime: Double
    
    private enum RecipeCodingKeys: String, CodingKey {
        case label
        case image
        case uri
        case url
        case shareAs
        case ingredientLines
        case ingredients
        case totalTime
    }
    
    init() {
        self.label = ""
        self.image = ""
        self.uri = ""
        self.url = ""
        self.shareAs = ""
        self.ingredientLines = [""]
        self.ingredients = [IngredientAPI()]
        self.totalTime = 0.0
    }
    
//    init(label: String,
//         image: String,
//         uri: String,
//         url: String,
//         shareAs: String,
//         ingredientLines: [String],
//        ingredients: [Ingredient2],
//        totalTime: Double) {
//        self.label = label
//        self.image = image
//        self.uri = uri
//        self.url = url
//        self.shareAs = shareAs
//        self.ingredientLines = ingredientLines
//        self.ingredients = ingredients
//        self.totalTime = totalTime
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RecipeCodingKeys.self)
        label = try container.decodeIfPresent(String.self, forKey: .label) ?? "N/A"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? "N/A"
        uri = try container.decodeIfPresent(String.self, forKey: .uri) ?? "N/A"
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? "N/A"
        shareAs = try container.decodeIfPresent(String.self, forKey: .shareAs) ?? "N/A"
        ingredientLines = try container.decodeIfPresent([String].self, forKey: .ingredientLines) ?? ["N/A"]
        ingredients = try container.decodeIfPresent([IngredientAPI].self, forKey: .ingredients) ?? [IngredientAPI()]
        totalTime = try container.decodeIfPresent(Double.self, forKey: .totalTime) ?? 0.0
    }
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
    
    static func formatedTime(time: Double) -> String {
        if time < 60 {
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

// MARK: - IngredientAPI

struct IngredientAPI: Codable {
    var food: String
    
    private enum IngredientCodingKeys: String, CodingKey {
        case food
    }
    
    init() {
        self.food = ""
    }
    
    init(food: String) {
        self.food = food
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IngredientCodingKeys.self)
        food = try container.decodeIfPresent(String.self, forKey: .food) ?? "N/A"
    }
    
}


