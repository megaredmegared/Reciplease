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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadMoreButton: UIButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    // MARK: - Search for more results
    @IBAction func moreRecipes() {
        hide(button: true, activity: false)
        searchRecipes()
    }
    
    func hide(button: Bool, activity: Bool) {
        loadMoreButton.isHidden = button
        self.activityIndicator.isHidden = activity
    }
    
    func updateLoadButton() {
        let numberOfRecipesLoaded = recipes.hits.count
        let totalRecipes = recipes.count
        if numberOfRecipesLoaded < totalRecipes {
            loadMoreButton.setTitle("\(numberOfRecipesLoaded)/\(totalRecipes) + load more recipes...", for: .normal)
        } else if numberOfRecipesLoaded >= totalRecipes {
            loadMoreButton.setTitle("All \(totalRecipes) recipes are loaded !", for: .disabled)
            print(numberOfRecipesLoaded)
            print(totalRecipes)
            loadMoreButton.isEnabled = false
        }
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
        
        // FIXME: - Put in get func
        var ingredientsNames = ""
        // Fill ingredientsNames
        let ingredients = recipe.recipe.ingredients
        for (index, ingredient) in ingredients.enumerated() {
            // insert the name of the ingredient
            ingredientsNames += "\(ingredient.food)"
            if index == ingredients.count - 1 {
                ingredientsNames += "."
            } else {
                ingredientsNames += ", "
            }
        }
        
        
        
        // FIXME: - load image
        //        let imageUrl = recipe.recipe.image
        //        var imageOK: UIImage? = UIImage(named: "ingredients")
        
        //        AF.download(imageUrl).validate().responseData { response in
        //            guard let image = UIImage(data: response.value ?? Data()) else {
        //                imageOK = UIImage(named: "ingredients")
        //                return
        //            }
        //
        //            imageOK = image
        //
        //        }
        var imageOK = UIImage(named: "ingredients")
        
        cell.configureWith(image: imageOK, recipe: recipeName, ingredients: ingredientsNames)
        
        return cell
    }
    
    // MARK: - Search recipes
    func searchRecipes() {
        
        let recipesLoaded = self.recipes.hits.count
        let numberOfRecipesToFetch = 10
        
        APIClient.search(numberOfRecipesToFetch: numberOfRecipesToFetch, recipes: recipes, ingredients: ingredients) { response in
            
            switch response.result {
                
            case .success:
                
                guard let recipesResponse = response.value else {
                    return
                }
                
                // set the next range of recipes to fetch
                self.recipes.from = recipesLoaded
                self.recipes.to = self.recipes.from + numberOfRecipesToFetch
                // add new fetched recipes
                self.recipes.hits += recipesResponse.hits
                // fetch the total existing recipes
                self.recipes.count = recipesResponse.count
                // update the tableView with the new datas
                self.tableView.reloadData()
                self.updateLoadButton()
                self.hide(button: false, activity: true)
                
            case let .failure(error):
                print("""
                    debug error:
                    \(error)
                    """)
            }
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
