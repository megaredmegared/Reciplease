
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchRecipe(numberOfRecipesToFetch: Int, ingredients: [Ingredient], recipes: Recipes)
    
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
        case .searchRecipe:
            return .get
        }
    }
    
    // MARK: - BaseURL
    
    private var baseURL: String {
        switch self {
        case .searchRecipe:
            return "https://api.edamam.com"
        }
    }
    
    // MARK: - Path
    
    private var path: String {
        switch self {
        case .searchRecipe:
            let identification = "app_id=\(ApiKeys.appID)&app_key=\(ApiKeys.appKey)"
            return "/search?\(identification)"
        }
    }
    
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .searchRecipe(let numberOfRecipesToFetch, let ingredients, let recipes):
            // make one string of ingredient with no white spaces

            let ingredientLine = ingredients
                .compactMap({$0.name})
                .joined(separator: ",")
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let fromInt = recipes.to ?? 0
            let from = String(fromInt)
            let to = String((fromInt) + numberOfRecipesToFetch)
            let time = "1%2B"
            return ["q": ingredientLine, "from": from, "to": to, "time": time]
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        switch self {
        case .searchRecipe:
            
            // convert parameters in one string because method is get and not post so no httpbody
            var parametersString = ""
            var parametersArray = [""]
            if let parameters = self.parameters as? [String: String] {
                for (key, value) in parameters {
                    let parameter = "&" + key + "=" + value
                    parametersArray.append(parameter)
                }
            }
            // use array sorted to have always the same order from, q, time, to
            parametersString = parametersArray.sorted().joined()
            
            // concatenation of the elements in an URL
            let stringUrl = self.baseURL + self.path + parametersString
            let url = try stringUrl.asURL()
            
            // creation of the URLRequest
            let urlRequest: URLRequest = try URLRequest(url: url, method:  HTTPMethod(rawValue: method.rawValue))
            
            print(urlRequest)
            
            return urlRequest
        }
    }
}

