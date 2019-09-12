//
//  SearchTableViewController.swift
//  Reciplease
//
//  Created by megared on 12/06/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import Alamofire

class SearchTableViewController: UITableViewController {
    
    var ingredients = Ingredient.all
    
    var recipes = Recipes()
    var images = [UIImage?]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRecipes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
    }
    
    // MARK: - Search for more results
    @IBAction func moreRecipes() {
        searchRecipes()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipes.hits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = self.recipes.hits[indexPath.row]
        // Configure the cell...
        
        let recipeName = recipe.recipe.label
        let ingredients = recipe.recipe.ingredients
        var ingredientsNames = ""
    
        for (index, ingredient) in ingredients.enumerated() {
            // insert the name of the ingredient
            ingredientsNames += "\(ingredient.food)"
            if index == ingredients.count - 1 {
                ingredientsNames += "."
            } else {
                ingredientsNames += ", "
            }
            
        }
        
        // FIXME: - clearer code needed
        let image = UIImage(named: "ingredients")
        
        cell.configureWith(image: image, recipe: recipeName, ingredients: ingredientsNames)
        
        return cell
    }
    
    
    // MARK: - Search recipes
    func searchRecipes() {
        let ingredients = Ingredient.makeOneString(from: self.ingredients)
        let url = "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)"
        let from = self.recipes.from
        let to = self.recipes.from + 7
        let fromString = String(from)
        let toString = String(to)

        let parameters = ["from": fromString, "to": toString, "q": ingredients]

        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: Recipes.self) { response in
            debugPrint("Response: \(response)")

            switch response.result {
            case .success:
                print("Validation Successful")
                guard let recipesResponse = response.value else {
                    return
                }
                // FIXME: - solve that things
                self.recipes.from = recipesResponse.to + 1
                self.recipes.to = self.recipes.from + 7

                self.recipes.hits += recipesResponse.hits


                for (index, _) in self.recipes.hits.enumerated() {
                    print(self.recipes.hits[index].recipe.label)
                }
                print(recipesResponse.to + 1)
                print(self.recipes.from + 7)
                print(self.recipes.from)
                print(self.recipes.to)
                
                
            case let .failure(error):
                print(error)
            }
            self.tableView.reloadData()

        }
    
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
     guard
     let selectedCell = sender as? UITableViewCell,
     let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == "RecipeDetails"
     else {
     fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
     }
        // Pass the selected object to the new view controller.
        let recipe = self.recipes.hits[selectedRowIndex]
     let recipeDetails = segue.destination as! DetailsViewController
     recipeDetails.recipe = recipe
    }
    

}
