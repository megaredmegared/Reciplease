
import Alamofire

///
enum APIRouter: URLRequestConvertible, URLConvertible {

    case searchRecipe(from: Int?, numberOfRecipesToFetch: Int, ingredients: [Ingredient])
    
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
        case .searchRecipe(let from, let numberOfRecipesToFetch, let ingredients):
            
            // make one string of ingredient with no white spaces
            var ingredientLine = ingredients
                .compactMap({$0.name})
                .joined(separator: ",")
            
            if let percentEncoding = ingredientLine.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                ingredientLine = percentEncoding
            }
            
            var fromInt = 0
            if let from = from {
                fromInt = from
            }
            
            let from = String(fromInt)
            let to = String((fromInt) + numberOfRecipesToFetch)
            let time = "1%2B"
            
            return ["q": ingredientLine, "from": from, "to": to, "time": time]
        }
    }
    
    // MARK: - URLConvertible
    
    func asURL() throws -> URL {
        switch self {
        case .searchRecipe:
            // convert parameters in one string because method is get and not post so no httpbody
            var parametersString = ""
            if let parameters = self.parameters as? [String: String] {
                for (key, value) in parameters {
                    parametersString += "&" + key + "=" + value
                }
            }
            
            // concatenation of the elements in an URL
            let stringUrl = self.baseURL + self.path + parametersString
            let url = try stringUrl.asURL()
            return url
        }
    }
    
        // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        switch self {
        case .searchRecipe:
            
            // creation of the URLRequest
            
            let urlRequest: URLRequest = try URLRequest(url: self.asURL(), method:  HTTPMethod(rawValue: method.rawValue))

            return urlRequest
        }
    }
}

