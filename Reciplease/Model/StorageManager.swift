//
//  DataManager.swift
//  Reciplease
//
//  Created by megared on 14/11/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
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
    func insertFavoriteRecipe(_ recipe: Recipe?, image: Data?, thumbnail: Data?, save: Bool) {
        guard let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: backgroundContext) as? FavoriteRecipe else { return }

        let ingredients = recipe?.ingredients
        let ingredientsLines = ingredients?.compactMap({$0.text})
//        let ingredientsLines = IngredientAPI.listIngredientsLines(ingredients: ingredients)
        
        favoriteRecipe.uri = recipe?.uri
        favoriteRecipe.name = recipe?.label
        favoriteRecipe.url = recipe?.url
        favoriteRecipe.shareAs = recipe?.shareAs
        favoriteRecipe.ingredients = ingredientsLines
        favoriteRecipe.imageThumbnail = thumbnail
        favoriteRecipe.image = image
        favoriteRecipe.time = recipe?.totalTime ?? 0
        
        if save == true {
            self.save()
        }
    }
    
    /// Create a stored ingredient
    func insertIngredient(name: String, save: Bool) {
        guard let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: backgroundContext) as? Ingredient else { return }
        ingredient.name = name
        
        if save == true {
            self.save()
        }
    }
    
    /// Read all favorites recipes
    func fetchAllFavoritesRecipes() -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        //  array of NSSortDescriptors to sort favoritesRecipes by name
               request.sortDescriptors = [
                   NSSortDescriptor(key: "name", ascending: true)
               ]
        guard let favortiesRecipes = try? persistentContainer.viewContext.fetch(request) else {
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
        guard let ingredients = try? persistentContainer.viewContext.fetch(request) else {
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
    
    func remove( objectID: NSManagedObjectID, save: Bool ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        
        if save == true {
            self.save()
        }
    }
}


