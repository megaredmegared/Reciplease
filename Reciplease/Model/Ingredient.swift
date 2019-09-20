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
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }
    
    // MARK: - Decompositing of the text line in more ingredients
    /// Formating ingredient name
    static private func formatIngredient(name: String) -> String? {
        var ingredientName = name
        /// remove unwanted caracters
        let characterToTrim = CharacterSet.init(charactersIn: " ./@')([]_;?!+*$€^¨£`%<>#°§")
        ingredientName = name.trimmingCharacters(in: characterToTrim)
        /// return nil if just a whitespace
        if ingredientName == "" {
            return nil
        }
        return ingredientName
    }
    
    /// Separate multi ingredients entries by ","
    static func formatingList(listOfNames: String) {
        let ingredientNameList = listOfNames.components(separatedBy: ",")
        var cleanNamedIngredients: [String] = []
        
        // Clean the name of the ingredient
        for ingredientName in ingredientNameList {
            if let name = self.formatIngredient(name: ingredientName) {
                cleanNamedIngredients.append(name)
            }
        }
        
        // delete duplicated names
        cleanNamedIngredients = Array(Set(cleanNamedIngredients))
        
        // remove ingredients that are already listed
        for ingredientName in cleanNamedIngredients {
            let ingredients = Ingredient.all
            for ingredient in ingredients {
                if (ingredient.name != nil) {
                    if ingredientName == ingredient.name {
                        if let index = cleanNamedIngredients.firstIndex(of: ingredientName) {
                            cleanNamedIngredients.remove(at: index)
                        }
                    }
                }
                
            }
            
        }
        
        // Save the ingredients
        for ingredientName in cleanNamedIngredients {
            
            let ingredient = Ingredient(context: AppDelegate.viewContext)
            ingredient.name = ingredientName
            try? AppDelegate.viewContext.save()
        }
    }
    
    // MARK: - Transform an array of ingredients in a single String line
    /// List the names of all ingredients in one string
    static func makeOneString(from ingredients: [Ingredient]) -> String {
        var ingredientsNames = ""
        for ingredient in ingredients {
            // insert a coma if not the first in the list
            if ingredients.firstIndex(of: ingredient) != 0 {
                ingredientsNames += ","
            }
            // insert the name of the ingredient
            ingredientsNames += ingredient.name ?? ""
        }
        return ingredientsNames
    }
}

// MARK: - Make ingredient comparable
extension Ingredient: Comparable {
    static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        
        return lhs.name ?? "" < rhs.name ?? ""
    }
    
    
}



