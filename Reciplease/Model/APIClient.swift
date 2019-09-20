
import Alamofire

class APIClient {
    /// search function for recipes datas
    static func search(numberOfRecipesToFetch: Int, recipes: Recipes, ingredients: [Ingredient], completionHandler: @escaping (_ response: DataResponse<Recipes, AFError>) -> Void ) {

        AF.request(APIRouter.searchRecipe(numberOfRecipesToFetch: numberOfRecipesToFetch, Intingredients: ingredients, recipes: recipes)).validate().responseDecodable(of: Recipes.self) { response in
            completionHandler(response)
        }
    }
    
}
