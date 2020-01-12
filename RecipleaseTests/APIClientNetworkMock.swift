
import Foundation
@testable import Reciplease

/// Mock call for testing
class APIClientNetworkMock: APIClientNetworkProtocol {
    private var data: Data?
    private var response: HTTPURLResponse?
    private var error: Error?

    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func get<T: Codable>(request: URLRequest, completionHandler: @escaping (T?, Error?) -> Void) {
        
        let decoder = JSONDecoder()
        
        guard let data = data, let value = try? decoder.decode(T.self , from: data) else {
            return completionHandler(nil, FakeResponseData.RecipesError.badData)
        }
        
        guard let response = self.response,
            response.statusCode == 200 else {
            return completionHandler(nil, FakeResponseData.RecipesError.badResponse)
        }
        
        guard self.error == nil else {
            return completionHandler(nil, FakeResponseData.RecipesError.error)
        }
        
        completionHandler(value, nil)
        
    }
}
