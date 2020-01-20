
import Foundation

class FakeResponseData {
    
    //MARK: - Fake data response
    
    /// Fake response OK
    static let responseOK = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    /// Fake response KO
    static let responseKO = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    /// Fake error
    enum RecipesError: Error {
        case badData
        case badResponse
        case error
    }
 
    /// Fake data KO
    static let incorrectData = "error".data(using: .utf8)!

    /// Fake data OK
    static var fakeRecipes: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "FakeRecipesJson", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
}
