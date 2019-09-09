//
//  SearchViewController.swift
//  Reciplease
//
//  Created by megared on 12/06/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var listIngredients: UITableView!
    
   
    //var ingredients = Ingredient.all.sorted(by: { $0.name! < $1.name! })
    var ingredients = Ingredient.all.sorted(by: < )
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // add logo to navigation
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
    }
    
    
    @IBAction func addIngredients() {
        guard let listOfNames = ingredientTextField.text else {
            return
        }
        
        Ingredient.formatingList(listOfNames: listOfNames)
        
        ingredientTextField.text = ""
        ingredients = Ingredient.all.sorted(by: < )
        listIngredients.reloadData()
    }
    
    // trigger button "Search recipes"
    @IBAction func searchRecipe() {

        let ingredientsNames = listIngredientsNames(for: ingredients)
//        APIRecipe.search(for: ingredientsNames)
        let url = "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)"

//        AF.request(url ,method: .get, parameters: parameters).validate().responseDecodable(of: Recipes.self) { response in
//            debugPrint("Response: \(response)")
//
//        }
        
        let parameters = ["from": "0", "to": "1", "q": ingredientsNames]
        
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: Recipes.self) { response in
            debugPrint("Response: \(response)")
        }
    }
    
}

/// List the names of all ingredients in one string
private func listIngredientsNames(for ingredients: [Ingredient]) -> String {
    var ingredientsNames = ""
    for ingredient in ingredients {
        // insert a coma if not the first in the list
        if ingredients.firstIndex(of: ingredient) != 0 {
            ingredientsNames += ", "
        }
        // insert the name of the ingredient
        ingredientsNames += ingredient.name ?? ""
    }
    return ingredientsNames
}

// MARK: - List of ingredients
extension SearchViewController: UITableViewDataSource {
    
    // Return the number of rows for the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    // Provide a cell object for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
    
    // Enable swipe-to-delete feature
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // handle delete by removing the data from the array first and then removing the tableview row
            
            let ingredient = ingredients[indexPath.row]
            removeIngredient(ingredient: ingredient)
            listIngredients.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    // Button to clear the ingredients list
    @IBAction func clearIngredientsList() {
        for ingredient in ingredients {
            removeIngredient(ingredient: ingredient)
        }
        listIngredients.reloadData()
    }
    
    /// Remove a stored ingredient
    private func removeIngredient(ingredient: Ingredient) {
        AppDelegate.persistentContainer.viewContext.delete(ingredient)
        ingredients.remove(at: 0)
        try? AppDelegate.viewContext.save()
        
    }
}

// MARK: - Keyboard
extension SearchViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredients()
        ingredientTextField.resignFirstResponder()
        return true
    }
}



