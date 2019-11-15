//
//  DataManager.swift
//  Reciplease
//
//  Created by megared on 14/11/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
//import Foundation
import CoreData

class StorageManager {
    
    let persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: - CRUD
    
    /// Create a stored favorite recipe
    func insertFavoriteRecipe(_ recipe: Recipes.Hit.Recipe, image: Data, thumbnail: Data) {
        guard let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: backgroundContext) as? FavoriteRecipe else { return }
        
        var ingredientsNames = [String]()
        let ingredients = recipe.ingredients
        
        for ingredient in ingredients {
            let ingredientName = ingredient.food
            ingredientsNames.append(ingredientName)
        }
        
        favoriteRecipe.uri = recipe.uri
        favoriteRecipe.name = recipe.label
        favoriteRecipe.url = recipe.url
        favoriteRecipe.shareAs = recipe.shareAs
        favoriteRecipe.ingredients = ingredientsNames
        favoriteRecipe.ingredientsLines = recipe.ingredientLines
        favoriteRecipe.imageThumbnail = thumbnail
        favoriteRecipe.image = image
    }
    
    /// Create a stored ingredient
    func insertIngredient( name: String) {
        guard let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: backgroundContext) as? Ingredient else { return }
        ingredient.name = name
    }
    
    /// Read all favorites recipes
    func fetchAllFavoritesRecipes() -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        //  array of NSSortDescriptors to sort favoritesRecipes by name
               request.sortDescriptors = [
                   NSSortDescriptor(key: "name", ascending: true)
               ]
        guard let favortiesRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favortiesRecipes
    }
    
    /// Read all ingredients
    func fetchAllIngredients() -> [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        //  array of NSSortDescriptors to sort favoritesRecipes by name
               request.sortDescriptors = [
                   NSSortDescriptor(key: "name", ascending: true)
               ]
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }

    
}


