//
//  APIRouterTestCase.swift
//  RecipleaseTests
//
//  Created by megared on 29/10/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import Reciplease

class APIRouterTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGivenRequestToCreate_WhenCreatingRequest_ThenRequestIsCreated() {
        let url = URL(string: "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)&to=10&q=chicken")
        let requestToCreate = URLRequest(url: url!)
        
//        let ingredients: [Ingredient] = ["chicken"]
//        let recipes =
//        let request = APIRouter.searchRecipe(numberOfRecipesToFetch: 20, ingredients: ingredients, recipes: recipes)
    }
}
