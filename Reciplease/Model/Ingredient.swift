//
//  Ingredient.swift
//  Reciplease
//
//  Created by megared on 07/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Ingredient: NSManagedObject {
    
    // MARK: - Variables    
    static var all: [Ingredient] {
        let storageManager = StorageManager()
        return storageManager.fetchAllIngredients()
    }
    
    // MARK: - Decompositing of the text line in more ingredients

    /// Formating ingredient name
    static private func formatIngredient(name: String) -> String? {
        var ingredientName = name
        /// remove unwanted caracters
        let characterToTrim = CharacterSet.init(charactersIn: " ./@')([]_;?!+*$€^¨'£`%<>#°§-")
        ingredientName = name.trimmingCharacters(in: characterToTrim)
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
            let storageManager = StorageManager()
            storageManager.insertIngredient(name: ingredientName, save: true)
        }
    }
    
    // MARK: - Transform an array of ingredients in a single String line
    /// List the names of all ingredients in one string
    static func makeOneString(from ingredients: [Ingredient]) -> String {
        var ingredientsNames = [String]()
        for ingredient in ingredients {
            if let ingredientName = ingredient.name {
                ingredientsNames.append(ingredientName)
            }
        }
        return ingredientsNames.formatListNames()
    }
    
    /// List the names of ingredients in array
    static func listNames(ingredients: [IngredientAPI]) -> [String]? {
        var ingredientsNames = [String]()
        for ingredient in ingredients {
            if let ingredientName = ingredient.food {
                ingredientsNames.append(ingredientName)
            }
        }
        if ingredientsNames == [] {
            return nil
        } else {
            return ingredientsNames
        }
    }
}

extension Collection where Element == String {
    /// Format array of string in one string with "," and a end "."
    func formatListNames() -> String {
        return self
            .joined(separator: ",")
            .appending(".")
    }
}

extension String {
    /// check if word exist in English
    func isRealEnglishWord() -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}


