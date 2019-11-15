
import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var listIngredients: UITableView!
    
    // MARK: - Variables
    
//    var ingredients: [Ingredient] { Ingredient.all.sorted(by: < ) }
    
    var ingredients: [Ingredient] { Ingredient.all }
    
    let storageManager = StorageManager()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add logo to navigation bar
        navigationItem.titleView = UIImageView.init(image: .logoReciplease)
    } 
}

// MARK: - TableView list of ingredients

extension SearchViewController: UITableViewDataSource {
    
    // Return the number of rows for the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    // Provide a cell object for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .ingredientCell, for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
    
    // Enable swipe-to-delete feature
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ingredient = ingredients[indexPath.row]
//            Ingredient.remove(ingredient)
            storageManager.remove(objectID: ingredient.objectID)
            storageManager.save()
            listIngredients.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Buttons Actions

extension SearchViewController {
    
    /// Add ingredients to the list
    @IBAction func addIngredients() {
        guard let listOfNames = ingredientTextField.text else {
            return
        }
        Ingredient.formatingList(listOfNames: listOfNames)
        // Reset ingredient text field
        ingredientTextField.text = ""
        listIngredients.reloadData()
    }
    
    /// Button to clear the ingredients list
    @IBAction func clearIngredientsList() {
        for ingredient in ingredients {
//            Ingredient.remove(ingredient)
            storageManager.remove(objectID: ingredient.objectID)
            storageManager.save()
        }
        listIngredients.reloadData()
    }
    
    /// trigger button "Search recipes"
    @IBAction func searchRecipe() {
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



