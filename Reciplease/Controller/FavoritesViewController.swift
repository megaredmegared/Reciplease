//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by megared on 13/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var howToAddFavoriteMessage: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favoritesRecipes: [FavoriteRecipe] = FavoriteRecipe.all.sorted(by: < )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        let nibName = UINib(nibName: "RecipesTableViewCell", bundle: nil)
        favoritesTableView.register(nibName, forCellReuseIdentifier: "RecipesCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        
        updateList()
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
     }

    private func updateList() {
        favoritesRecipes = FavoriteRecipe.all.sorted(by: < )
    }
    
    func animateHiddenView(_ view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    func showHowToAddFavoriteMessage() {
        if favoritesRecipes.isEmpty {
            animateHiddenView(howToAddFavoriteMessage, hidden: false)
            favoritesTableView.isHidden = true
        } else {
            howToAddFavoriteMessage.isHidden = true
            favoritesTableView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.favoritesRecipes.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let favoriteRecipe = self.favoritesRecipes[indexPath.row]
        let name = favoriteRecipe.name ?? ""
        let ingredients = favoriteRecipe.ingredients ?? []
        
        func listFavIngredients(ingredients: [String]) -> String {
             var ingredientsNames = ""
             for (index, ingredient) in ingredients.enumerated() {
                 // insert the name of the ingredient
                 ingredientsNames += "\(ingredient)"
                 if index == ingredients.count - 1 {
                     ingredientsNames += "."
                 } else {
                     ingredientsNames += ", "
                 }
             }
             return ingredientsNames
         }
        let defaultImageThumbnail = UIImage(named: "ingredients")?.pngData()
        
        let imageThumbnail = UIImage(data: favoriteRecipe.imageThumbnail ?? defaultImageThumbnail!)
       
        let ingredientsNames = listFavIngredients(ingredients: ingredients)
    
        cell.favoriteConfigureWith(recipe: name, ingredients: ingredientsNames, imageThumbnail: imageThumbnail)
        
        return cell
    }
    
    /// Remove a stored favorite recipe
    private func removeFavoriteRecipe(favoriteRecipe: FavoriteRecipe) {
        AppDelegate.persistentContainer.viewContext.delete(favoriteRecipe)
        favoritesRecipes.remove(at: 0)
        try? AppDelegate.viewContext.save()
        
        
    }
    
    /// Clear the list of favorites recipes
    @IBAction func clearButtonTapped(_ sender: Any) {
        for favoriteRecipe in favoritesRecipes {
            removeFavoriteRecipe(favoriteRecipe: favoriteRecipe)
        }
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
    }
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = self.favoritesTableView.cellForRow(at: indexPath)
         self.performSegue(withIdentifier: "FavoritesDetails", sender: cell)
     }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard
            let selectedCell = sender as? UITableViewCell,
            let selectedRowIndex = favoritesTableView.indexPath(for: selectedCell)?.row, segue.identifier == "FavoritesDetails"
            else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        // Pass the selected recipe to the DetailsViewController
        let favoriteRecipe = favoritesRecipes[selectedRowIndex]
    
        
        let recipe = FavoriteRecipe.transformFavoriteRecipeInRecipe(favoriteRecipe)
        let details = segue.destination as! DetailsViewController
        
        details.recipe = recipe
        details.imageThumbnail = UIImage(data: favoriteRecipe.imageThumbnail ?? UIImage.placeholderImage.pngData()!)
        details.image = UIImage(data: favoriteRecipe.image ?? UIImage.placeholderImage.pngData()!)
        
    }

}
