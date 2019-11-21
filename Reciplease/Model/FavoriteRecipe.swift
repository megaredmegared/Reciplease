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
    
    static func transformFavoriteRecipeInRecipe(_ favoriteRecipe: FavoriteRecipe) -> Recipe? {
//        var recipe = Recipe(label: "", image: "", uri: "", url: "", shareAs: "", ingredientLines: [""], ingredients: [Ingredient2(food: "")], totalTime: 0.0)
         var recipe = Recipe()
        var ingredients = [IngredientAPI]()
        
        for name in favoriteRecipe.ingredients! {
            let ingredient = IngredientAPI(food: name)
            ingredients.append(ingredient)
        }
        
        recipe.label = favoriteRecipe.name ?? "No recipe name"
        recipe.ingredientLines = favoriteRecipe.ingredientsLines ?? ["no ingredients"]
        recipe.ingredients = ingredients
        recipe.shareAs = favoriteRecipe.shareAs ?? ""
        recipe.uri = favoriteRecipe.uri ?? ""
        recipe.url = favoriteRecipe.url ?? ""
        recipe.totalTime = favoriteRecipe.time
        
        return recipe
    }
    
}


