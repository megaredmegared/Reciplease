//
//  IngredientTestCase.swift
//  RecipleaseTests
//
//  Created by megared on 23/10/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class IngredientTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGivenOneStringListOfIngredients_WhenFormatingTheString_ThenArrayOfStringNameIngredient() {
        let stringOfIngredients = "butter,  kjh, tomato juice, big Mac 45, ,"
        
        let listOfIngredients = Ingredient.formatingList(listOfNames: stringOfIngredients)
        // verif par element
        XCTAssertEqual(listOfIngredients.sorted(), ["Butter", "Tomato Juice", "Big Mac"].sorted())
    }
    
    
}
