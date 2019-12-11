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
    
    // MARK: - Decompositing of the text line in more ingredients

    /// Formating ingredient name
    static private func formatIngredient(name: String) -> String? {
        
        /// remove unwanted caracters and capitalize first letter of each word
        let ingredientName = name
            .allowedCharacters
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
        
        /// check if word exist
        if ingredientName.isRealEnglishWord() == false {
            return nil
        }
        /// return nil if just a whitespace
        if ingredientName == "" {
            return nil
        }
        return ingredientName
    }
    
    /// Separate multi ingredients entries by ","
    static func formatingList(listOfNames: String) -> [String] {
        var ingredientsNamesList = listOfNames.components(separatedBy: ",")
        
        // Clean the name of the ingredient
        ingredientsNamesList = ingredientsNamesList.compactMap({formatIngredient(name: $0)})
    
        // delete duplicated names
        ingredientsNamesList = Array(Set(ingredientsNamesList))
        
        // remove ingredients that are already listed
        for ingredientName in ingredientsNamesList {
            let ingredients = Ingredient.all
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


