//
//  FavoritesRecipes.swift
//  Reciplease
//
//  Created by megared on 13/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {
    
    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favortiesRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favortiesRecipes
    }

}


