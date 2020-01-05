import Foundation
import Alamofire

/// protocol needed to test APIClient
protocol APIClientNetworkProtocol {
    func get<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void)
}

/// Default call for production
class APIClientNetworkAlamofire: APIClientNetworkProtocol {
    func get<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void) {
        AF.request(request).validate().responseDecodable(of: T.self) { response in
            completionHandler(response.value, response.error)
        }
    }
}

/// APIClient
class APIClient {

    private let network: APIClientNetworkProtocol

    init(_ network: APIClientNetworkProtocol = APIClientNetworkAlamofire()) {
        self.network = network
    }

    func search(from: Int?, numberOfRecipesToFetch: Int, ingredients: [Ingredient], completionHandler: @escaping (Recipes?, Error?) -> Void) {

        do {
            network.get(request: try APIRouter.searchRecipe(from: from, numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients).asURLRequest()) { (result: Recipes?, error: Error?) in
                completionHandler(result, error)
            }
        } catch {
            completionHandler(nil, error)
        }
    }
}
