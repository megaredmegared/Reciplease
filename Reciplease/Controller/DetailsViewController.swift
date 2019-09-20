//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by megared on 12/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var starFavorite: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientList: UITextView!
    
    var recipe: Recipes.Hit?

    override func viewDidLoad() {
        super.viewDidLoad()

        // add logo to navigation
        navigationItem.titleView = UIImageView.init(image: UIImage(named: "logoReciplease"))
        
        showDetail()
    }
    
    @IBAction func viewInstructions() {
    }
    
    func showDetail() {
        
        recipeTitle.text = recipe?.recipe.label
        var ingredientText: String {
            var text = ""
            for line in recipe?.recipe.ingredientLines ?? [""] {
                text += line + "\n"
            }
            
            return text
        }
        
        ingredientList.text = ingredientText
    }

    // MARK: - Navigation
    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
     
//         Pass the selected object to the new view controller.
        let stringURL = recipe?.recipe.shareAs ?? ""
        let recipeURL = URL(string: stringURL)
        let send = segue.destination as! WebViewController
        send.url = recipeURL
    }
}
