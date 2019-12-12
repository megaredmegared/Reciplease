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
        let rows = customStorageManager.fetchAllIngredients()
        XCTAssertEqual(rows.count, 0)
        
        // add 3 ingredients
        customStorageManager.insertIngredient(name: "Chicken", save: false)
        customStorageManager.insertIngredient(name: "Tomato", save: false)
        customStorageManager.insertIngredient(name: "Pinapple", save: true)
        let ingredients = customStorageManager.fetchAllIngredients()

        // check there is 3 ordered ingredients
        XCTAssertEqual(ingredients[0].name, "Chicken")
        XCTAssertEqual(ingredients[1].name, "Pinapple")
        XCTAssertEqual(ingredients[2].name, "Tomato")
        XCTAssertEqual(ingredients.count, 3)
        
        //MARK: - APIRouter
        // check if APIRouter request is correct
        let url = URL(string: "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)&from=2&q=Chicken,Pinapple,Tomato&time=1%2B&to=12")
        let requestToCreate = URLRequest(url: url!)
        
        let apiRouter = APIRouter.searchRecipe(from: 2, numberOfRecipesToFetch: 10, ingredients: ingredients)
        
        let request = APIRouter.asURLRequest(apiRouter)
        // decomposer la request
        XCTAssertEqual(requestToCreate, try request())
        
        //MARK: - Ingredient
        
        let stringOfIngredients = "butter,  kjh, tomato juice, big Mac 45, , tomato"
        
        let listOfIngredients = Ingredient.formatingList(listOfNames: stringOfIngredients, ingredients: ingredients)
        
        XCTAssertEqual(listOfIngredients.sorted(), ["Butter", "Tomato Juice", "Big Mac"].sorted())
        
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
        var recipes = customStorageManager.fetchAllFavoritesRecipes()
        let objectID = recipes[3].objectID
        customStorageManager.remove(objectID: objectID, save: true)
        // update recipe
        recipes = customStorageManager.fetchAllFavoritesRecipes()
        
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
        
        XCTAssertEqual(customStorageManager.fetchAllFavoritesRecipes().count, 3)
        
        // MARK: - FavoriteRecipe
        let favoriteRecipe = recipes[0]
        if let recipe = FavoriteRecipe.transformFavoriteRecipeInRecipe(favoriteRecipe) {
            XCTAssertEqual(recipe.label, "ASIAN CHICKEN SALAD WITH GRILLED PINEAPPLE")
            XCTAssertEqual(recipe.ingredients?[0].text, "2 pieces grilled chicken breast")
            XCTAssertEqual(recipe.ingredients?[1].text, "1 tablespoon soy vay teriyaki sauce (or your preference)")
            XCTAssertEqual(recipe.ingredients?[2].text, "2 cups arugula")
            XCTAssertEqual(recipe.shareAs, "http://www.edamam.com/recipe/asian-chicken-salad-with-grilled-pineapple-2b1e27b21abfacab4e81b4b220ee9225/chicken%2C+tomato%2C+pineapple")
            XCTAssertEqual(recipe.uri, "http://www.edamam.com/ontologies/edamam.owl#recipe_2b1e27b21abfacab4e81b4b220ee9225")
            XCTAssertEqual(recipe.url, "https://food52.com/recipes/16604-asian-chicken-salad-with-grilled-pineapple")
            XCTAssertEqual(recipe.totalTime, 313.0)
        }
        
        
    }
       
}
