
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchRecipe(ingredient: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .searchRecipe:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchRecipe:
//            let appID = "${844bfc12}" //ApiKeys().appID
//            let appKey = "${9b24648aba0f0acbab1c905c2f77f751}" //ApiKeys().appKey
            return "/search"//"/search?q=\(ingredient)&app_id=\(appID)&app_key=\(appKey)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .searchRecipe(let ingredient):
            let appID = "844bfc12"
            let appKey = "9b24648aba0f0acbab1c905c2f77f751"
            return [K.APIParameterKey.ingredient: ingredient, K.APIParameterKey.appKey: appKey, K.APIParameterKey.appID: appID]
        }
    }
    
    var dataRequest: DataRequest {
        switch self {
        case .searchRecipe:
            return AF.request("https://api.edamam.com/search/get", parameters: parameters).validate().responseJSON { response in
                debugPrint(response)
            }
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
//        let urlComponents = URLComponents(string: "https://api.edamam.com/search?app_id=${844bfc12}&app_key=${9b24648aba0f0acbab1c905c2f77f751}&q=chicken")
//        let url = try K.ProductionServer.baseURL.asURL().appendingPathComponent(path)
//
//        var urlRequest = URLRequest(url: url) //URLRequest(url: url.appendingPathComponent(path))
//
//        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//
//        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//
//        // Parameters
//        if let parameters = parameters {
//            do {
//                print("ça marche")
//                print(urlRequest)
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//                print("ça marche2")
//                print(urlRequest)
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
//
        


        
        
        print("""

debug address

""")
       print(urlRequest)
        
        return urlRequest!
    }
}

