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
    
    /// Separate multi ingredients entries by ","
    static func formatingList(listOfNames: String, ingredients: [Ingredient] = Ingredient.all) -> [String] {
        var ingredientsNamesList = listOfNames.components(separatedBy: ",")
        
        // Clean the name of the ingredient
        ingredientsNamesList = ingredientsNamesList.compactMap({$0.formatIngredient})
    
        // delete duplicated names
        ingredientsNamesList = Array(Set(ingredientsNamesList))
        
        // remove ingredients that are already listed
        for ingredientName in ingredientsNamesList {
            for ingredient in ingredients {
                if (ingredient.name != nil) {
                    if ingredientName == ingredient.name {
                        if let index = ingredientsNamesList.firstIndex(of: ingredientName) {
                            ingredientsNamesList.remove(at: index)
                        }
                    }
                }
            }
        }
            return ingredientsNamesList
    }
}
