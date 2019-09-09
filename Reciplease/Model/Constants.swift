//
//  Constants.swift
//  Reciplease
//
//  Created by megared on 04/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.edamam.com"
    }
    
    struct APIParameterKey {
        static let ingredient = "q"
        static let appID = "app_id"
        static let appKey = "app_key"
    }
}
// TODO: maybe trash this !
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
enum ContentType: String {
    case json = "application/json"
}

