//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by megared on 12/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var starFavorite: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UITextView!
    
    // MARK: - Variables
    
    var recipe: Recipes.Hit.Recipe?
    var favoritesRecipes = FavoriteRecipe.all
    var image: UIImage?
    var imageThumbnail: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add logo to navigation
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        
        showDetail()
        updateStarButton()
        
    }
    
    /// Check if the recipe is in the Favorite
    private func isInFavorites() -> Bool {
        let recipeURI = recipe?.uri
        if self.favoritesRecipes.contains(where: {$0.uri == recipeURI}) {
            return true
        } else {
            return false
        }
    }
    
    /// Update star Button
    private func updateStarButton() {
        if isInFavorites() == true {
            starFavorite.image = UIImage(named: "starFilled")
        } else {
            starFavorite.image = UIImage(named: "starEmpty")
        }
    }
    
    /// activate or deactivate favorite
    private func addOrDeleteFavorite() {
        if isInFavorites() == false {
          addFavorite()
            starFavorite.image = UIImage(named: "starFilled")
            print("ajoute aux favoris")
        } else {
            starFavorite.image = UIImage(named: "starEmpty")
            deleteFavorite()
            print("déjà dans les favoris")
        }
    }
    
    /// add favorite
    private func addFavorite() {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        var ingredients = [String]()
        // FIXME: WARNING optional
        for (_, ingredient) in recipe!.ingredients.enumerated() {
            let ingredientName = ingredient.food
            ingredients.append(ingredientName)
        }
        
        favoriteRecipe.uri = recipe?.uri
        favoriteRecipe.name = recipe?.label
        favoriteRecipe.url = recipe?.url
        favoriteRecipe.shareAs = recipe?.shareAs
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.ingredientsLines = recipe?.ingredientLines
        favoriteRecipe.imageThumbnail = imageThumbnail?.pngData()
    
        try? AppDelegate.viewContext.save()
    }
    
    /// delete favorite
    private func deleteFavorite() {
        let recipeURI = recipe?.uri
        for (index, recipe) in self.favoritesRecipes.enumerated() {
            if recipe.uri == recipeURI {
                AppDelegate.persistentContainer.viewContext.delete(recipe)
                self.favoritesRecipes.remove(at: index)
                try? AppDelegate.viewContext.save()
            }
        }
    }


    // Update the view with infos of the recipe
    func showDetail() {
        recipeImage.image = imageThumbnail
        recipeTitle.text = recipe?.label
        var ingredientText: String {
            var text = ""
            for line in recipe?.ingredientLines ?? [""] {
                text += line + "\n"
            }

            return text
        }

        ingredientList.text = ingredientText
    }
    
    // MARK: - Actions
    
    @IBAction func triggerStarButton(_ sender: Any) {
        //addOrDeleteFavorite()
        //deleteFavorite()
        addFavorite()
        updateStarButton()
    }
    
    @IBAction func viewInstructions() {
    }

    // MARK: - Navigation
    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
     
//         Pass the selected object to the new view controller.
        let stringURL = recipe?.shareAs ?? ""
        let recipeURL = URL(string: stringURL)
        let send = segue.destination as! WebViewController
        send.url = recipeURL
    }
}
