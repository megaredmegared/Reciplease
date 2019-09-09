//
//  Recipe.swift
//  Reciplease
//
//  Created by megared on 05/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

struct Recipes: Decodable {
    
    var from: Int
    var to: Int
    var more: Bool
    var count: Int
    
    var hits: [Hit]
    
    struct Hit: Decodable {
       var recipe: Recipe

        struct Recipe: Decodable {
            var label: String
            var image: String
            var url: String
            var ingredientLines: [String]
            var ingredients: [Ingredient]

            struct Ingredient: Decodable {
                var text: String
                var food: String
            }
        }
    }
}
