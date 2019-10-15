//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by megared on 13/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var howToAddFavoriteMessage: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: - Variables
    
    var favoritesRecipes: [FavoriteRecipe] { FavoriteRecipe.all.sorted(by: < ) }
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add logo to navigation bar
        navigationItem.titleView = UIImageView.init(image: .logoReciplease)
        
        // Set the custom tableViewCell for the favoritesTableView
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        favoritesTableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
    }
    
    // MARK: - Functions
    
    /// Animate the appearance of howToAddFavoriteMessage label
    private func animateHiddenView(_ view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    /// Check if the list of favorite is empty then show a message on how to had favorites
    private func showHowToAddFavoriteMessage() {
        if favoritesRecipes.isEmpty {
            animateHiddenView(howToAddFavoriteMessage, hidden: false)
            favoritesTableView.isHidden = true
        } else {
            howToAddFavoriteMessage.isHidden = true
            favoritesTableView.isHidden = false
        }
    }
}
    
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritesRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .recipesCell, for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let favoriteRecipe = self.favoritesRecipes[indexPath.row]
        let name = favoriteRecipe.name ?? ""
        let ingredients = favoriteRecipe.ingredients ?? []
        
//        /// Format a text ingredient list in one single String
//        func listFavIngredients(ingredients: [String]) -> String {
//            var ingredientsNames = ""
//            for (index, ingredient) in ingredients.enumerated() {
//                // insert the name of the ingredient
//                ingredientsNames += "\(ingredient)"
//                if index == ingredients.count - 1 {
//                    ingredientsNames += "."
//                } else {
//                    ingredientsNames += ", "
//                }
//            }
//            return ingredientsNames
//        }
        let defaultImageThumbnail = UIImage.placeholderImage.pngData()
        
        let imageThumbnail = UIImage(data: favoriteRecipe.imageThumbnail ?? defaultImageThumbnail!)
        
        let ingredientsNames = Ingredient.listIngredients2(ingredients: ingredients)
        
        cell.favoriteConfigureWith(recipe: name, ingredients: ingredientsNames, imageThumbnail: imageThumbnail)
        
        return cell
    }
    
    // Enable swipe-to-delete feature
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteRecipe = favoritesRecipes[indexPath.row]
            FavoriteRecipe.remove(favoriteRecipe)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
        showHowToAddFavoriteMessage()
    }
    
    /// Clear the list of favorites recipes
    @IBAction func clearButtonTapped(_ sender: Any) {
        for favoriteRecipe in favoritesRecipes {
            FavoriteRecipe.remove(favoriteRecipe)
        }
        favoritesTableView.reloadData()
        showHowToAddFavoriteMessage()
    }
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.favoritesTableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: .segueFavoritesDetails, sender: cell)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard
            let selectedCell = sender as? UITableViewCell,
            let selectedRowIndex = favoritesTableView.indexPath(for: selectedCell)?.row, segue.identifier == .segueFavoritesDetails
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
