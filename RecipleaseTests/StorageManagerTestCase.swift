//
//  StorageManagerTestCase.swift
//  RecipleaseTests
//
//  Created by megared on 15/11/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class StorageManagerTestCase: XCTestCase {
    
    // this class instantiates its own custom storage manager, using an in-memory data backing
    var customStorageManager: StorageManager?
    
    // Using the in-memory container unit testing requires loading the xcdatamodel to be loaded from the main bundle
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    // The customStorageManager specifies in-memory by providing a custom NSPersistentContainer
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()

    override func setUp() {
        // Before each unit test, setUp is called, which creates a fresh, empty in-memory database for the test to use
        customStorageManager = StorageManager(container: mockPersistantContainer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNoIngredientAdd3Then3OrderedIngredients() {
        guard let customStorageManager = self.customStorageManager else {
            XCTFail()
            return
        }
        
        // check no ingredient
        let rows = customStorageManager.fetchAllFavoritesRecipes()
        XCTAssertEqual(rows.count, 0)
        
        // add 3 ingredients
        customStorageManager.insertIngredient(name: "chicken", save: false)
        customStorageManager.insertIngredient(name: "tomato", save: false)
        customStorageManager.insertIngredient(name: "pinapple", save: true)
        let ingredients = customStorageManager.fetchAllIngredients()

        // check there is 3 ordered ingredients
        XCTAssertEqual(ingredients[0].name, "chicken")
        XCTAssertEqual(ingredients[1].name, "pinapple")
        XCTAssertEqual(ingredients[2].name, "tomato")
        XCTAssertEqual(ingredients.count, 3)
    }
    
    func testNoRecipeAdd4AndRemoveOneThen3OrderedRecipes() {
        guard let customStorageManager = self.customStorageManager else {
            XCTFail()
            return
        }
        
        // check no recipe
        let rows = customStorageManager.fetchAllFavoritesRecipes()
        XCTAssertEqual(rows.count, 0)
        
        // add 3 recipes
        customStorageManager.insertFavoriteRecipe(recipe1, image: imageData, thumbnail: imageThumbnailData, save: false)
        customStorageManager.insertFavoriteRecipe(recipe2, image: imageData, thumbnail: imageThumbnailData, save: false)
        customStorageManager.insertFavoriteRecipe(recipe3, image: nil, thumbnail: nil, save: false)
        customStorageManager.insertFavoriteRecipe(recipe3, image: nil, thumbnail: nil, save: true)
        
        // remove one recipe
        let recipes = customStorageManager.fetchAllFavoritesRecipes()
        let objectID = recipes[3].objectID
        customStorageManager.remove(objectID: objectID, save: true)
        
        // check there is 3 ordered recipes
        let imageData = "image".data(using: .utf8)!
        let imageThumbnailData = "imageThumbnail".data(using: .utf8)!
        
        XCTAssertEqual(recipes[0].name, "ASIAN CHICKEN SALAD WITH GRILLED PINEAPPLE")
        
        XCTAssertEqual(recipes[0].image, imageData)
        XCTAssertEqual(recipes[0].imageThumbnail, imageThumbnailData)
        
        XCTAssertEqual(recipes[1].name, "Chicken and Pineapple Salad")
        XCTAssertEqual(recipes[1].image, imageData)
        XCTAssertEqual(recipes[1].imageThumbnail, imageThumbnailData)
        
        XCTAssertEqual(recipes[2].name, "Pineapple-Tomato Salsa")
        XCTAssertNil(recipes[2].image)
        XCTAssertNil(recipes[2].imageThumbnail)
        
        XCTAssertEqual(recipes[3].name, "Pineapple-Tomato Salsa")
        XCTAssertNil(recipes[3].image)
        XCTAssertNil(recipes[3].imageThumbnail)
        
        XCTAssertEqual(recipes.count, 3)
    }
       

}
