//
//  IngredientService.swift
//  Reciplease
//
//  Created by megared on 07/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class IngredientService {
    static let shared = IngredientService()
    private init() {}
    
    var ingredients: [Ingredient] = []
    
    func add(ingredient: Ingredient) {
        ingredients.insert(ingredient, at: 0)
    }
}
