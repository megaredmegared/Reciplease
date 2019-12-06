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
        let storageManager = StorageManager()
        return storageManager.fetchAllFavoritesRecipes()
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
    
    /// Transform Favorite Recipe in Recipe
    static func transformFavoriteRecipeInRecipe(_ favoriteRecipe: FavoriteRecipe) -> Recipe? {
        var recipe = Recipe()
        var ingredients = [IngredientAPI]()
  
        for text in favoriteRecipe.ingredients ?? [String]() {
            let ingredient = IngredientAPI(text: text)
            ingredients.append(ingredient)
        }
        
        recipe.label = favoriteRecipe.name
        recipe.ingredients = ingredients
        recipe.shareAs = favoriteRecipe.shareAs
        recipe.uri = favoriteRecipe.uri
        recipe.url = favoriteRecipe.url
        recipe.totalTime = favoriteRecipe.time
        
        return recipe
    }
}


