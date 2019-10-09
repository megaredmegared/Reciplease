//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by megared on 26/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit
import SafariServices

//protocol JobProtocol {
//    var title: String { get }
//    var description: String { get }
//    var isFavorite: Bool { get }
//}
//
//struct JobServiceModel: JobProtocol {
//    var title: String {
//        return dictionary["title"] ?? ""
//    }
//
//    var description: String {
//        return dictionary["description"] ?? ""
//    }
//
//    var dictionary: [String: String]
//}
//
//struct JobServiceEntity: JobProtocol {
//    var title: String
//    var description: String
//    let isFavorite = true
//}

class FavoritesDetailsViewController: UIViewController {

    @IBOutlet weak var detailsView: DetailsView!
    
    @IBOutlet weak var starFavorite: UIBarButtonItem!
    
    let starFilled = UIImage(named: "starFilled")
    let starEmpty = UIImage(named: "starEmpty")
    
    var favoriteRecipes = FavoriteRecipe.all
    var favoriteRecipe: FavoriteRecipe?
    var temporaryFavoriteRecipe: Recipes.Hit.Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        showDetail()
        detailsView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /// Update star Button
      private func updateStarButton() {
          if favoriteRecipe?.isFavorite == true {
              starFavorite.image = starFilled
          } else {
              starFavorite.image = starEmpty
          }
      }
    
    private func updateList() {
           favoriteRecipes = FavoriteRecipe.all
       }
    
    /// activate or deactivate favorite
     private func addOrDeleteFavorite() {
         if favoriteRecipe?.isFavorite == false {
//             addFavorite()
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
//        for (_, ingredient) in recipe!.ingredients.enumerated() {
//            let ingredientName = ingredient.food
//            ingredients.append(ingredientName)
//        }

        favoriteRecipe.uri = temporaryFavoriteRecipe?.uri
        favoriteRecipe.name = temporaryFavoriteRecipe?.label
        favoriteRecipe.url = temporaryFavoriteRecipe?.url
        favoriteRecipe.shareAs = temporaryFavoriteRecipe?.shareAs
//        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.ingredientsLines = temporaryFavoriteRecipe?.ingredientLines
//        favoriteRecipe.imageThumbnail = imageThumbnail?.pngData()
//        favoriteRecipe.image = image?.pngData()

        try? AppDelegate.viewContext.save()
        updateList()
        updateStarButton()
    }
    
    /// delete favorite
    private func deleteFavorite() {
        for (index, favoriteRecipe) in self.favoriteRecipes.enumerated() {
            if favoriteRecipe == self.favoriteRecipe {
                // add in temporary file
                temporaryFavoriteRecipe?.uri = favoriteRecipe.uri ?? ""
                temporaryFavoriteRecipe?.label = favoriteRecipe.name ?? ""
                temporaryFavoriteRecipe?.url = favoriteRecipe.url ?? ""
                temporaryFavoriteRecipe?.shareAs = favoriteRecipe.shareAs ?? ""
//                ingredients = favoriteRecipe.ingredients
                temporaryFavoriteRecipe?.ingredientLines = favoriteRecipe.ingredientsLines ?? [""]
//                imageThumbnail?.pngData() = favoriteRecipe.imageThumbnail
//                image?.pngData() = favoriteRecipe.image
                print("add to temporary file")
                // delete from coredata
                AppDelegate.persistentContainer.viewContext.delete(favoriteRecipe)
                favoriteRecipes.remove(at: index)
                try? AppDelegate.viewContext.save()
            }
        }
        
        updateList()
        updateStarButton()
        print("delete from favorite 2")
    }
    
    // Update the view with infos of the recipe
    func showDetail() {
        let defaultImage = UIImage(named: "ingredients")?.pngData()
        
        let image = UIImage(data: favoriteRecipe?.image ?? defaultImage!)
        detailsView.recipeImage.image = image
        detailsView.recipeTitle.text = favoriteRecipe?.name
        var ingredientListText: String {
            var text = ""
            for line in favoriteRecipe?.ingredientsLines ?? [""] {
                text += line + "\n"
            }

            return text
        }

        detailsView.recipeIngredientsList.text = ingredientListText
    }
    
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    //         Get the new view controller using segue.destination.
//
//    //         Pass the selected object to the new view controller.
//            let stringURL = favoriteRecipe?.shareAs ?? ""
//            let recipeURL = URL(string: stringURL)
//            let send = segue.destination as! WebViewController
//            send.url = recipeURL
//        }
    
    @IBAction func starFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        addOrDeleteFavorite()
//        deleteFavorite()
    }
    
}


extension FavoritesDetailsViewController: ButtonActionDelegate, SFSafariViewControllerDelegate {

    func openSafariVC() {
        let stringURL = favoriteRecipe?.shareAs ?? ""
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

        print("bouboule2")
        openSafariVC()
//        performSegue(withIdentifier: "DetailsWebView", sender: sender)
    }
    
}
