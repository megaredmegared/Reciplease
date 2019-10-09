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

extension FavoriteRecipe {
    
    /// Check if a recipe is already marked as favorite
    var isFavorite: Bool {
        
    if FavoriteRecipe.all.contains(where: {$0.uri == uri}) {
            return true
        } else {
            return false
        }
    }
}

