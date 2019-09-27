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
    
    var favoritesRecipes = FavoriteRecipe.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nibName = UINib(nibName: "RecipesTableViewCell", bundle: nil)
//        favoritesTableView.register(nibName, forCellReuseIdentifier: "RecipesCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateList()
    }

    private func updateList() {
        favoritesRecipes = FavoriteRecipe.all
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return self.favoritesRecipes.count
       }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesRecipesCell", for: indexPath) as? RecipesTableViewCell else {
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
        
        let ingredientsNames = listFavIngredients(ingredients: ingredients)
    
        cell.favoriteConfigureWith(recipe: name, ingredients: ingredientsNames)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard
            let selectedCell = sender as? UITableViewCell,
            let selectedRowIndex = favoritesTableView.indexPath(for: selectedCell)?.row, segue.identifier == "FavoritesRecipeDetails"
            else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        // Pass the selected recipe to the DetailsViewController
        let favoriteRecipe = favoritesRecipes[selectedRowIndex]
        let details = segue.destination as! FavoritesDetailsViewController
        
        details.favoriteRecipe = favoriteRecipe
    }

}
