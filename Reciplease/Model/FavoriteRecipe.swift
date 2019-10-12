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

extension FavoriteRecipe: Comparable {
    static func < (lhs: FavoriteRecipe, rhs: FavoriteRecipe) -> Bool {
        
        return lhs.name ?? "" < rhs.name ?? ""
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
    
    static func transformFavoriteRecipeInRecipe(_ favoriteRecipe: FavoriteRecipe) -> Recipes.Hit.Recipe? {
        var recipe = Recipes.Hit.Recipe()
        var ingredients = [Recipes.Hit.Recipe.Ingredient]()
        
       for name in favoriteRecipe.ingredients! {
        let ingredient = Recipes.Hit.Recipe.Ingredient(food: name)
        ingredients.append(ingredient)
        }
        
        recipe.label = "No recipe name" //favoriteRecipe.name ??
        recipe.ingredientLines = favoriteRecipe.ingredientsLines ?? ["no ingredients"]
        recipe.ingredients = ingredients
        recipe.shareAs = favoriteRecipe.shareAs ?? ""
        recipe.uri = favoriteRecipe.uri ?? ""
        recipe.url = favoriteRecipe.url ?? ""
        
        return recipe
    }
}


