//
//  FavoriteRecipeTestCase.swift
//  RecipleaseTests
//
//  Created by megared on 11/12/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import Reciplease

class FavoriteRecipeTestCase: XCTestCase {

    /// test FavoriteRecipe.all
    func testGivenFavoritesRecipesWhenCompareThenEqual() {
        let allFavoritesRecipes = FavoriteRecipe.all
        
        let storageManager = StorageManager()
        
        XCTAssertEqual(allFavoritesRecipes, storageManager.fetchAllFavoritesRecipes())
    }
}
