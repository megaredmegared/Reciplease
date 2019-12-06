//
//  ExtensionController.swift
//  Reciplease
//
//  Created by megared on 06/12/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

extension Collection where Element == String {
    /// Format array of string in one string with "," and a end "."
    func formatListNames() -> String {
        return self
            .joined(separator: ",")
            .appending(".")
    }
}
