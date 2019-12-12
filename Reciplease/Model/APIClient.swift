import Foundation
import Alamofire

//protocol APIClientNetworkProtocol {
//    func get<Result: Codable>(url: String, completionHandler:(Error?, Result?) -> Void)
//}
//
//class APIClientNetworkAlamofire: APIClientNetworkProtocol {
//    func get<Result: Codable>(url: String, completionHandler:(Error?, Result?) -> Void) {
//        //AF.request(//)
//    }
//}
//
//struct APIClientNetworkMock: APIClientNetworkProtocol {
//    var data: Data?
//    var response: HTTPURLResponse?
//    var error: Error?
//    func get<Result: Codable>(url: String, completionHandler:(Error?, Result?) -> Void) {
//        guard error == nil else {
//            return completionHandler(error, nil)
//        }
//
//        guard let response = response, response.statusCode == 200 else {
//            return completionHandler(error, nil)
//        }
//
//        /* */
//    }
//}

class APIClient {
    
    private let manager: Session
//    private var network: APIClientNetworkProtocol = APIClientNetworkAlamofire()
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    /// search function for recipes datas
    func search(from: Int?, numberOfRecipesToFetch: Int, ingredients: [Ingredient], completionHandler: @escaping (_ response: DataResponse<Recipes, AFError>) -> Void ) {
        
        //network?.get(url: <#T##String#>, completionHandler: <#T##(Error?, Decodable & Encodable) -> Void#>)

        AF.request(APIRouter.searchRecipe(from: from, numberOfRecipesToFetch: numberOfRecipesToFetch, ingredients: ingredients)).validate().responseDecodable(of: Recipes.self) { response in
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
