import Foundation
import Alamofire

//protocol APIClientNetworkProtocol {
//    func get<Result: Codable>(request: URLRequest, completionHandler: @escaping (Result?, Error?) -> Void)
//}
//
//class APIClientNetworkAlamofire: APIClientNetworkProtocol {
//    func get<Result: Codable>(request: URLRequest, completionHandler: @escaping (Result?, Error?) -> Void) {
//        //AF.request(//)
//        AF.request(request).validate().responseDecodable(of: Result.self) { response in
//            completionHandler(response.value, response.error)
//        }
//    }
//}
//
//class APIClientNetworkMock: APIClientNetworkProtocol {
//    var data: Data?
//    var response: HTTPURLResponse?
//    var error: Error?
//    
//    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
//        self.data = data
//        self.response = response
//        self.error = error
//    }
//    
//    func get<Result: Codable>(request: URLRequest, completionHandler: @escaping (Result?, Error?) -> Void) {
//        guard error == nil else {
//            return completionHandler(nil, error)
//        }
//
//        guard let response = response, response.statusCode == 200 else {
//            return completionHandler(nil, error)
//        }
//
//        /* */
//    }
//}

//class APIClient {
//
//    private let network: APIClientNetworkProtocol
//
//    init(_ network: APIClientNetworkProtocol = APIClientNetworkAlamofire()) {
//        self.network = network
//    }
//
//    func search(from: Int?, numberOfRecipesToFetch: Int, ingredients: [Ingredient], completionHandler: @escaping (Recipes?, Error?) -> Void) {
//        do {
//            network.get(request: try APIRouter.searchRecipe(from: from, numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients).asURLRequest()) { (result: Recipes?, error: Error?) in
//                completionHandler(result, error)
//            }
//        } catch {
//            completionHandler(nil, error)
//        }
//    }
//}
class APIClient {

    private let manager: Session

    init(manager: Session = Session.default) {
        self.manager = manager
    }

    /// search function for recipes datas
    func search(from: Int?, numberOfRecipesToFetch: Int, ingredients: [Ingredient], completionHandler: @escaping (_ response: DataResponse<Recipes, AFError>) -> Void ) {

        manager.request(APIRouter.searchRecipe(from: from, numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients)).validate().responseDecodable(of: Recipes.self) { response in
            completionHandler(response)
        }
    }
}
 
