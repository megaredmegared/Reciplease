import XCTest
@testable import Reciplease
@testable import Alamofire

class APIClientTestCase: XCTestCase {
    
    /// test all good
    func testGivenAllGood_WhenPostCallBack_ThenSuccesCallBackAndData() {
        
        // Given
        let apiClient = APIClient(APIClientNetworkMock(
            data: FakeResponseData.fakeRecipes,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiClient.search(from: 0, numberOfRecipesToFetch: 3, ingredients: []) { (result, error) in
            
            // Then
            let count = 203
            let from = 0
            let to = 3
            
            XCTAssertEqual(result?.count, count)
            XCTAssertEqual(result?.from, from)
            XCTAssertEqual(result?.to, to)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing error
    func testGivenError_WhenPostCallBack_ThenFailedCallBack() {
        
        // Given
        let apiClient = APIClient(APIClientNetworkMock(
            data: nil,
            response: nil,
            error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiClient.search(from: 0, numberOfRecipesToFetch: 3, ingredients: []) { (result, error) in
            
            // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing bad response
    func testGivenBadResponse_WhenPostCallBack_ThenFailedCallBack() {
        
        // Given
        let apiClient = APIClient(APIClientNetworkMock(
            data: FakeResponseData.fakeRecipes,
            response: FakeResponseData.responseKO,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiClient.search(from: 0, numberOfRecipesToFetch: 3, ingredients: []) { (result, error) in
            
            // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad data
    func testGivenBadData_WhenPostCallBack_ThenFailedCallBack() {
        
        // Given
        let apiClient = APIClient(APIClientNetworkMock(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiClient.search(from: 0, numberOfRecipesToFetch: 3, ingredients: []) { (result, error) in
            
            // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
     /// Testing no response, no data
    func testGivenNoData_WhenPostCallBack_ThenFailedCallBack() {
        
        // Given
        let apiClient = APIClient(APIClientNetworkMock(
            data: nil,
            response: nil,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiClient.search(from: 0, numberOfRecipesToFetch: 3, ingredients: []) { (result, error) in
            
            // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
