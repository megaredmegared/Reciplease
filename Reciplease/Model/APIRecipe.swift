//
//  APIRecipe.swift
//  Reciplease
//
//  Created by megared on 09/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import Alamofire

class APIRecipe {
    
    // WARNING app_id must be before app_key in the URL
    private static let url = "https://api.edamam.com/search?app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)"

    static func search(for ingredients: String) {
        
        let parameters = ["q": ingredients]
        
        AF.request(url ,method: .get, parameters: parameters).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print(error)
            }
        }
        
    }
}
