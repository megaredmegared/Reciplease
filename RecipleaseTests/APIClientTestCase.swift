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
            XCTAssertEqual(result?.count, FakeData.count)
            XCTAssertEqual(result?.from, FakeData.from)
            XCTAssertEqual(result?.to, FakeData.to)
            XCTAssertNil(error)
            XCTAssertEqual(result?.hits?[0].recipe?.ingredients?.count, FakeData.hits1[0].recipe?.ingredients?.count)
            XCTAssertEqual(result?.hits?[0].recipe?.ingredients?[0].text, FakeData.hits1[0].recipe?.ingredients?[0].text)
            XCTAssertEqual(result?.hits?[0].recipe?.ingredients?[1].text, FakeData.hits1[0].recipe?.ingredients?[1].text)
            XCTAssertEqual(result?.hits?[0].recipe?.ingredients?[2].text, FakeData.hits1[0].recipe?.ingredients?[2].text)
            XCTAssertEqual(result?.hits?[0].recipe?.ingredients?[3].text, FakeData.hits1[0].recipe?.ingredients?[3].text)
            XCTAssertEqual(result?.hits?[0].recipe?.label, FakeData.hits1[0].recipe?.label)
            XCTAssertEqual(result?.hits?[0].recipe?.image, FakeData.hits1[0].recipe?.image)
            XCTAssertEqual(result?.hits?[0].recipe?.shareAs, FakeData.hits1[0].recipe?.shareAs)
            XCTAssertEqual(result?.hits?[0].recipe?.uri, FakeData.hits1[0].recipe?.uri)
            XCTAssertEqual(result?.hits?[0].recipe?.url, FakeData.hits1[0].recipe?.url)
            XCTAssertEqual(result?.hits?[0].recipe?.totalTime, FakeData.hits1[0].recipe?.totalTime)
            XCTAssertEqual(result?.hits?[1].recipe?.ingredients?.count, FakeData.hits1[1].recipe?.ingredients?.count)
            XCTAssertEqual(result?.hits?[1].recipe?.ingredients?[0].text, FakeData.hits1[1].recipe?.ingredients?[0].text)
            XCTAssertEqual(result?.hits?[1].recipe?.ingredients?[1].text, FakeData.hits1[1].recipe?.ingredients?[1].text)
            XCTAssertEqual(result?.hits?[1].recipe?.ingredients?[2].text, FakeData.hits1[1].recipe?.ingredients?[2].text)
            XCTAssertEqual(result?.hits?[1].recipe?.label, FakeData.hits1[1].recipe?.label)
            XCTAssertEqual(result?.hits?[1].recipe?.image, FakeData.hits1[1].recipe?.image)
            XCTAssertEqual(result?.hits?[1].recipe?.shareAs, FakeData.hits1[1].recipe?.shareAs)
            XCTAssertEqual(result?.hits?[1].recipe?.uri, FakeData.hits1[1].recipe?.uri)
            XCTAssertEqual(result?.hits?[1].recipe?.url, FakeData.hits1[1].recipe?.url)
            XCTAssertEqual(result?.hits?[1].recipe?.totalTime, FakeData.hits1[1].recipe?.totalTime)
            XCTAssertEqual(result?.hits?[2].recipe?.ingredients?.count, FakeData.hits1[2].recipe?.ingredients?.count)
            XCTAssertEqual(result?.hits?[2].recipe?.ingredients?[0].text, FakeData.hits1[2].recipe?.ingredients?[0].text)
            XCTAssertEqual(result?.hits?[2].recipe?.ingredients?[1].text, FakeData.hits1[2].recipe?.ingredients?[1].text)
            XCTAssertEqual(result?.hits?[2].recipe?.ingredients?[2].text, FakeData.hits1[2].recipe?.ingredients?[2].text)
            XCTAssertEqual(result?.hits?[2].recipe?.label, FakeData.hits1[2].recipe?.label)
            XCTAssertEqual(result?.hits?[2].recipe?.image, FakeData.hits1[2].recipe?.image)
            XCTAssertEqual(result?.hits?[2].recipe?.shareAs, FakeData.hits1[2].recipe?.shareAs)
            XCTAssertEqual(result?.hits?[2].recipe?.uri, FakeData.hits1[2].recipe?.uri)
            XCTAssertEqual(result?.hits?[2].recipe?.url, FakeData.hits1[2].recipe?.url)
            XCTAssertEqual(result?.hits?[2].recipe?.totalTime, FakeData.hits1[2].recipe?.totalTime)
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
            error: FakeResponseData.RecipesError.error))
        
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
