//
//  Ingredient.swift
//  Reciplease
//
//  Created by megared on 07/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
    
    // MARK: - Variables    
    static var all: [Ingredient] {
        let storageManager = StorageManager()
        return storageManager.fetchAllIngredients()
    }
    
    // MARK: - Decompositing of the ingredients text line in an array
    
    // remove ingredients that are already listed
    static func removeAlreadylistedIngredient(ingredientsNamesList: [String], ingredients: [Ingredient] = Ingredient.all) -> [String] {
        ingredientsNamesList.filter { ingredientName in
            !ingredients.contains { $0.name == ingredientName }
        }
//        var ingredientsNamesList = ingredientsNamesList
//        for ingredientName in ingredientsNamesList {
//            for ingredient in ingredients {
//                if (ingredient.name != nil) {
//                    if ingredientName == ingredient.name {
//                        if let index = ingredientsNamesList.firstIndex(of: ingredientName) {
//                            ingredientsNamesList.remove(at: index)
//                        }
//                    }
//                }
//            }
//        }
//        return ingredientsNamesList
    }
    
}

