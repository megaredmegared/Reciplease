////
////  APIClientTestCase.swift
////  RecipleaseTests
////
////  Created by megared on 11/12/2019.
////  Copyright © 2019 OpenClassrooms. All rights reserved.
////
//
//import XCTest
//@testable import Reciplease
//@testable import Alamofire
//
//
//class APIClientTestCase: XCTestCase {
//
//    private var sut: APIClient!
//    
//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let manager: Session = {
//                 let configuration: URLSessionConfiguration = {
//                     let configuration = URLSessionConfiguration.default
//                     configuration.protocolClasses = [MockURLProtocol.self]
//                     return configuration
//                 }()
//                 
//                 return Session(configuration: configuration)
//             }()
//        sut = APIClient(manager: manager)
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//         sut = nil
//    }
//
//    func testExample() {
//        
//        
//        
//    }
//    
//    func testStatusCode200ReturnsStatusCode200() {
//        // given
////        MockURLProtocol.responseWithStatusCode(code: 200)
////        
////        let expectation = XCTestExpectation(description: "Performs a request")
////        
////        // when
////        sut.search(numberOfRecipesToFetch: 10, recipes: recipes1, ingredients: ingredientsSearch1) { result in
////            XCTAssertEqual(result.response?.statusCode, 200)
////            expectation.fulfill()
////        }
////        
////        // then
////        wait(for: [expectation], timeout: 3)
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
