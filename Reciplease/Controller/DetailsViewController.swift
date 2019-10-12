//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by megared on 12/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices



class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var starFavorite: UIBarButtonItem!
    @IBOutlet weak var detailsView: DetailsView!

    
    // MARK: - Variables
    
    var recipe: Recipes.Hit.Recipe?
//    var favoritesRecipes: [FavoriteRecipe] = FavoriteRecipe.all
    
    var favoritesRecipes: [FavoriteRecipe] { FavoriteRecipe.all }
    
    var image: UIImage?
    var imageThumbnail: UIImage?
    let starFilled = UIImage(named: "starFilled")
    let starEmpty = UIImage(named: "starEmpty")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add logo to navigation
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        showDetails()
        detailsView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        updateList()
         updateStarButton()
    }
    
    /// Update
    private func updateFavorite() {
//        updateList()
        updateStarButton()
    }
    
//    private func updateList() {
//        favoritesRecipes = FavoriteRecipe.all
//    }
//
    //MARK: - Manage the Favorite
    
    /// Update star Button
    private func updateStarButton() {
        if recipe?.isFavorite == true {
            starFavorite.image = starFilled
        } else {
            starFavorite.image = starEmpty
        }
    }
    
    /// activate or deactivate favorite
    private func addOrDeleteFavorite() {
        if recipe?.isFavorite == false {
            addFavorite()
            print("ajouté aux favoris")
        } else {
            deleteFavorite()
            print("supprimé des favoris")
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
        favoriteRecipe.image = image?.pngData()
        
        try? AppDelegate.viewContext.save()
//        updateList()
        updateStarButton()
        
    }
    
    /// delete favorite
    private func deleteFavorite() {
        let recipeURI = recipe?.uri
        for (index, recipe) in self.favoritesRecipes.enumerated() {
            if recipe.uri == recipeURI {
                AppDelegate.persistentContainer.viewContext.delete(recipe)
//                self.favoritesRecipes.remove(at: index)
                try? AppDelegate.viewContext.save()
            }
        }
//        updateList()
        updateStarButton()
    }
    
    // MARK: - View
    // Update the view with infos of the recipe
    func showDetails() {
        
        detailsView.recipeImage.image = image //recipeTitle.text = recipe?.label
        detailsView.recipeTitle.text = recipe?.label //recipeTitle.text = recipe?.label
        var ingredientText: String {
            var text = ""
            for line in recipe?.ingredientLines ?? [""] {
                text += line + "\n"
            }
            
            return text
        }
        
        detailsView.recipeIngredientsList.text = ingredientText //ingredientList.text = ingredientText
    }
    
    // MARK: - Actions
    
    @IBAction func triggerStarButton(_ sender: Any) {
        addOrDeleteFavorite()
    }
    
    
    
    //    sender.performSegue(withIdentifier: "WebView", sender: sender)
    
    // MARK: - Navigation
    
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //         Get the new view controller using segue.destination.
//        
//        //         Pass the selected object to the new view controller.
//        let stringURL = recipe?.shareAs ?? ""
//        let recipeURL = URL(string: stringURL)
//        let send = segue.destination as! WebViewController
//        send.url = recipeURL
//    }
}

extension DetailsViewController: ButtonActionDelegate, SFSafariViewControllerDelegate {
    
    func openSafariVC() {
        let stringURL = recipe?.shareAs ?? ""
        let recipeURL = URL(string: stringURL)
        let safariVC = SFSafariViewController(url: recipeURL!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.preferredControlTintColor = .black
        safariVC.preferredBarTintColor = .mainColor
        
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func triggerWebButton(sender: UIButton) {
        openSafariVC()
    }
    
}
