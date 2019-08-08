//
//  SearchViewController.swift
//  Reciplease
//
//  Created by megared on 12/06/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var listIngredients: UITableView!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        /// add logo to navigation
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Adding ingredients
    func formatIngredient(name: String) -> String {
        /// remove whitespaces
        let ingredientNameTrimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        /// remove points
        let ingredientNameOutput = ingredientNameTrimmed.trimmingCharacters(in: .init(charactersIn: "."))

        return ingredientNameOutput
    }
    
    @IBAction func addIngredients() {
        guard let name = ingredientTextField.text else {
            return
        }
        /// Separate multi ingredients entries by ","
        let separatedIngredients = name.components(separatedBy: ",")
        
        for ingredientName in separatedIngredients {
            
            let name = formatIngredient(name: ingredientName)
            
            let ingredient = Ingredient(name: name)
            IngredientService.shared.add(ingredient: ingredient)
        }

        ingredientTextField.text = ""
        listIngredients.reloadData()
    }

}

// MARK: - List of ingredients
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientService.shared.ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
    // delete a row by swiping it
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // handle delete by removing the data from the array and removing the tableview row)
            IngredientService.shared.ingredients.remove(at: indexPath.row)
            listIngredients.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // Button to clear the ingredients list
    @IBAction func clearIngredientsList() {
        IngredientService.shared.ingredients = []
        listIngredients.reloadData()
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



