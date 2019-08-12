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
    
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }
}

// MARK: - Decompositing of the text line in more ingredients
extension Ingredient {
    
    /// Formating ingredient name
    static private func formatIngredient(name: String) -> String? {
        var ingredientName = name
        /// remove whitespaces
        ingredientName = name.trimmingCharacters(in: .whitespaces)
        /// remove points
        ingredientName = ingredientName.trimmingCharacters(in: .init(charactersIn: "."))
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
        print("1      \(cleanNamedIngredients)")
        
        // remove ingredients that are already listed
        for ingredientName in cleanNamedIngredients {
            let ingredients = Ingredient.all
            
            for ingredient in ingredients {
                if ingredientName == ingredient.name! {
                    if let index = cleanNamedIngredients.firstIndex(of: ingredientName) {
                        cleanNamedIngredients.remove(at: index)
                    }
                }
                
            }
            print("2      \(cleanNamedIngredients)")
        }
        
        // Save the ingredients
        for ingredientName in cleanNamedIngredients {
            
            let ingredient = Ingredient(context: AppDelegate.viewContext)
            print("3      \(cleanNamedIngredients)")
            ingredient.name = ingredientName
            try? AppDelegate.viewContext.save()
        }
    }
}
extension Ingredient: Comparable {
    static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        
        return lhs.name ?? "" < rhs.name ?? ""
    }
    
    
}


