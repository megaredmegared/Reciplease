
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
    
    /// Formating word
    func formatWord() -> String? {
        
        /// remove unwanted caracters and capitalize first letter of each word
        let word = self
            .allowedCharacters()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
        
        /// check if word exist
        if word.isRealEnglishWord == false {
            return nil
        }
        /// return nil if empty String
        if word.isEmpty {
            return nil
        }
        return word
    }
    
    /// Separate multi words entries by ","
    func formatList() -> [String] {
        var wordsList = self.components(separatedBy: ",")
        
        // Clean the name of the ingredient
        wordsList = wordsList.compactMap({$0.formatWord()})
        
        // delete duplicated names
        wordsList = Array(Set(wordsList))
        
        return wordsList
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
        } else if time.truncatingRemainder(dividingBy: 60) == 0  {
            let hours = time / 60
            return String(Int(hours)) + "h"
        } else {
            let hours = time / 60
            let minutes = time.truncatingRemainder(dividingBy: 60)
            return String(Int(hours)) + "h" + String(Int(minutes)) + "m"
        }
    }
}
