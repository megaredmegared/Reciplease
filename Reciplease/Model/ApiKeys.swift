//
//  ApiKeys.swift
//  Reciplease
//
//  Created by megared on 31/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

struct ApiKeys {
    let appID = valueForAPIKey(named: "app_id")
    let appKey = valueForAPIKey(named: "app_key")
}



