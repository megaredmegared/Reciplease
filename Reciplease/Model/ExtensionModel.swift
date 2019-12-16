//
//  ExtensionModel.swift
//  Reciplease
//
//  Created by megared on 06/12/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// check if word exist in English
    func isRealEnglishWord() -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    /// Check for string to return only allowed characters
    var allowedCharacters: String {
        let characters = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ,")
        return self.filter {characters.contains($0) }
    }
    
    /// Formating ingredient name
    var formatIngredient: String? {
        
        /// remove unwanted caracters and capitalize first letter of each word
        let ingredientName = self
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
    var formatList: [String] {
        var ingredientsNamesList = self.components(separatedBy: ",")
        
        // Clean the name of the ingredient
        ingredientsNamesList = ingredientsNamesList.compactMap({$0.formatIngredient})
        
        // delete duplicated names
        ingredientsNamesList = Array(Set(ingredientsNamesList))
        
        
        return ingredientsNamesList
    }
}
