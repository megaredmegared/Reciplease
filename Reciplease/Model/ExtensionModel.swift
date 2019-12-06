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
}


