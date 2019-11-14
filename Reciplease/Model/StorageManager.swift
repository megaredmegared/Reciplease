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
    
    //MARK: CRUD
    func insertFavoriteRecipe( name: String,
                               image: Data,
                               imageThumbnail: Data,
                               ingredients: [String],
                               ingredientsLines: [String],
                               shareAs: String,
                               uri: String,
                               url: String
    ) -> FavoriteRecipe? {
        guard let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: backgroundContext) as? FavoriteRecipe else { return nil }
        favoriteRecipe.name = name
        favoriteRecipe.image = image
        favoriteRecipe.imageThumbnail = imageThumbnail
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.ingredientsLines = ingredientsLines
        favoriteRecipe.shareAs = shareAs
        favoriteRecipe.uri = uri
        favoriteRecipe.url = url

        return favoriteRecipe
    }
    
    func insertIngredient( name: String) -> Ingredient? {
        guard let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: backgroundContext) as? Ingredient else { return nil }
        ingredient.name = name
        return ingredient
    }

    func fetchAll() -> [ToDoItem] {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [ToDoItem]()
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
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
    
}
