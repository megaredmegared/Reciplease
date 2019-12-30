//import XCTest
//@testable import Reciplease
//@testable import Alamofire

//class APIClientTestCase: XCTestCase {

//    private var sut: APIClient!

//    override func setUp() {
//        super.setUp()
//
//        let manager: Session = {
//            let configuration: URLSessionConfiguration = {
//                let configuration = URLSessionConfiguration.default
//                configuration.protocolClasses = [MockURLProtocol.self]
//                return configuration
//            }()
//            return Session(configuration: configuration)
//        }()
//
//        sut = APIClient(manager: manager)
//    }

//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//
//        sut = nil
//    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
//    func testStatusCode200ReturnsStatusCode200() {
//        // given
//        MockURLProtocol.responseWithStatusCode(code: 200)
//
//        let expectation = XCTestExpectation(description: "Performs a request")
//
//        // when
//        sut.search(from: 2, numberOfRecipesToFetch: 20, ingredients: FakeData.ingredientsSearch1, completionHandler: { (response) in
//            XCTAssertEqual(response.response?.statusCode, 200)
//            expectation.fulfill()
//        })
//
//        // then
//        wait(for: [expectation], timeout: 3)
//    }

//}
