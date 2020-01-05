
import Foundation
import UIKit

extension String {
    /// check if word exist in English
    var isRealEnglishWord: Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    /// Check for string to return only allowed characters
    func allowedCharacters() -> String {
        let characters = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ,")
        return self.filter {characters.contains($0) }
    }
    
    /// Formating ingredient name
    func formatIngredient() -> String? {
        
        /// remove unwanted caracters and capitalize first letter of each word
        let ingredientName = self
            .allowedCharacters()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
        
        /// check if word exist
        if ingredientName.isRealEnglishWord == false {
            return nil
        }
        /// return nil if empty String
        if ingredientName.isEmpty {
            return nil
        }
        return ingredientName
    }
    
    /// Separate multi ingredients entries by ","
    func formatList() -> [String] {
        var ingredientsNamesList = self.components(separatedBy: ",")
        
        // Clean the name of the ingredient
        ingredientsNamesList = ingredientsNamesList.compactMap({$0.formatIngredient()})
        
        // delete duplicated names
        ingredientsNamesList = Array(Set(ingredientsNamesList))
        
        return ingredientsNamesList
    }
}

extension Double {
    
    ///format Time minute Double to a String in hours and minutes
    func formatTime() -> String? {
        let time = self
        if time == 0 {
            return nil
        } else if (1..<60).contains(time) {
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
