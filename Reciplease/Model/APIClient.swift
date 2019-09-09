
import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
       
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response:  AFDataResponse<T>) in
                completion(response.result)
                print("""
---------

debug

---------
""")
                print(response)
//                debugPrint(response) // TODO: à enlever
        }
    }

    static func searchRecipe(ingredient: String, completion:@escaping (Result<Recipes, AFError>)->Void) {
        performRequest(route: APIRouter.searchRecipe(ingredient: ingredient), completion: completion)
    }
    
}
