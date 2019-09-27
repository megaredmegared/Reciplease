//
//  SearchTableViewController.swift
//  Reciplease
//
//  Created by megared on 12/06/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SearchTableViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet var searchTableView: UITableView! // FIXME: obliger de faire un lien là ?
    
    
    let identities = ["", ""]
    var ingredients = Ingredient.all
    
    var recipes = Recipes()
    var images = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchRecipes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        
//        let nibName = UINib(nibName: "RecipesTableViewCell", bundle: nil)
//        searchTableView.register(nibName, forCellReuseIdentifier: "RecipesCell")
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
    
    private func hide(button: Bool, activity: Bool) {
        loadMoreButton.isHidden = button
        self.activityIndicator.isHidden = activity
    }
    
    private func updateLoadButton() {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = self.recipes.hits[indexPath.row]
        let recipeName = recipe.recipe.label
        
        // Fill all the ingredients names in one ingredientsNames String
        let ingredients = recipe.recipe.ingredients
        let ingredientsNames = Ingredient.listIngredients(ingredients: ingredients)
        
        // Load image
        let imageUrl: URL? = URL(string: recipe.recipe.image)
        
        cell.searchConfigureWith(imageUrl: imageUrl, recipe: recipeName, ingredients: ingredientsNames)
        
        return cell
    }
    
    // MARK: - Search recipes
    func searchRecipes() {
        
        let recipesLoaded = self.recipes.hits.count
        let numberOfRecipesToFetch = 20
        
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
            let selectedCell = sender as? RecipesTableViewCell,
            let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == "RecipeDetails"
            else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        // Pass the selected recipe to the DetailsViewController
        let recipe = self.recipes.hits[selectedRowIndex].recipe
        
        // FIXME: - fetch image in cache
        
        // fetch and cache images with Kingfisher
        
        let imageThumbnail = selectedCell.recipeImage.image
        let details = segue.destination as! DetailsViewController
        details.recipe = recipe
        details.imageThumbnail = imageThumbnail

    }

    
}
