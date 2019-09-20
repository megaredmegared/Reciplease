//
//  APIRecipe.swift
//  Reciplease
//
//  Created by megared on 09/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class APIRecipe {
    
    static func search(numberOfRecipesToFetch: Int, recipes: Recipes, ingredients: [Ingredient], completionHandler: @escaping (_ response: DataResponse<Recipes, AFError>) -> Void ) {
        let ingredientsline = Ingredient.makeOneString(from: ingredients)
        let url = "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)"
        let from = recipes.to
        let to = from + numberOfRecipesToFetch
        let fromString = String(from)
        let toString = String(to)
        
        let parameters = ["from": fromString, "to": toString, "q": ingredientsline]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: Recipes.self) { response in
            debugPrint("Response: \(response)")
            print("""


debug 2
\(AF.request(url, method: .get, parameters: parameters))





""")
            completionHandler(response)
            
            }
        }
    
}
