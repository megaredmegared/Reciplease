//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by megared on 26/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class FavoritesDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UITextView!
    
    var favoriteRecipe: FavoriteRecipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Update the view with infos of the recipe
    func showDetail() {
        image.image = UIImage(data: favoriteRecipe!.imageThumbnail!)
        recipeTitle.text = favoriteRecipe?.name
        var ingredientListText: String {
            var text = ""
            for line in favoriteRecipe?.ingredientsLines ?? [""] {
                text += line + "\n"
            }

            return text
        }

        ingredientList.text = ingredientListText
    }
    
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         Get the new view controller using segue.destination.
         
    //         Pass the selected object to the new view controller.
            let stringURL = favoriteRecipe?.shareAs ?? ""
            let recipeURL = URL(string: stringURL)
            let send = segue.destination as! WebViewController
            send.url = recipeURL
        }
    

}
