//
//  FavoritesDetailsViewController.swift
//  Reciplease
//
//  Created by megared on 26/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

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
    
    var favoriteRecipe: FavoriteRecipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        showDetail()
        // Do any additional setup after loading the view.
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
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         Get the new view controller using segue.destination.
         
    //         Pass the selected object to the new view controller.
            let stringURL = favoriteRecipe?.shareAs ?? ""
            let recipeURL = URL(string: stringURL)
            let send = segue.destination as! WebViewController
            send.url = recipeURL
        }
    

}
