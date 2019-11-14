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
        
        recipe.label = favoriteRecipe.name ?? "No recipe name"
        recipe.ingredientLines = favoriteRecipe.ingredientsLines ?? ["no ingredients"]
        recipe.ingredients = ingredients
        recipe.shareAs = favoriteRecipe.shareAs ?? ""
        recipe.uri = favoriteRecipe.uri ?? ""
        recipe.url = favoriteRecipe.url ?? ""
        
        return recipe
    }
    
    /// Remove a stored favorite recipe
    static func remove(_ favoriteRecipe: FavoriteRecipe) {
        AppDelegate.persistentContainer.viewContext.delete(favoriteRecipe)
        try? AppDelegate.viewContext.save()
    }
    
    /// Add a stored favorite recipe
    static func add(_ recipe: Recipes.Hit.Recipe, image: Data, thumbnail: Data) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
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
        
        try? AppDelegate.viewContext.save()
    }

    
    
}


