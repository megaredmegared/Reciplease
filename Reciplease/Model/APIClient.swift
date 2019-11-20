
import Alamofire

class APIClient {
    /// search function for recipes datas
    static func search(numberOfRecipesToFetch: Int, recipes: Recipes, ingredients: [Ingredient], completionHandler: @escaping (_ response: DataResponse<Recipes, AFError>) -> Void ) {

        AF.request(APIRouter.searchRecipe(numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients, recipes: recipes)).validate().responseDecodable(of: Recipes.self) { response in
            completionHandler(response)
        }
    }    
}


protocol Car {
    mutating func start()
    mutating func stop()
    mutating func changeSpeed(speed: Int)
}

struct Human {
    var car: Car
    
    mutating func goToWork() {
        car.start()
        car.changeSpeed(speed: 1)
        car.changeSpeed(speed: 2)
        car.changeSpeed(speed: 3)
        car.stop()
    }
    
    mutating func goToHome() {
        car.start()
        car.changeSpeed(speed: 1)
        car.changeSpeed(speed: 2)
        car.changeSpeed(speed: 3)
        car.changeSpeed(speed: 2)
        car.changeSpeed(speed: 3)
        car.stop()
    }
}

struct Peugeot208: Car {
    var speed: Float = 0
    mutating func start() {
        speed = 5
    }
    
    mutating func stop() {
        speed = 0
    }
    
    mutating func changeSpeed(speed: Int) {
        switch speed {
        case 1: self.speed = 30
        case 2: self.speed = 50
        case 3: self.speed = 80
        default: break
        }
    }
    
    
}

struct RenaultZoe: Car {
    var speed: Float = 0
    mutating func start() {
        speed = 5
    }
    
    mutating func stop() {
        speed = 0
    }
    
    mutating func changeSpeed(speed: Int) {
        switch speed {
        case 1: self.speed = 30
        case 2: self.speed = 60
        default: break
        }
    }
}

let sebastien = Human(car: RenaultZoe())
let vincent = Human(car: Peugeot208())
