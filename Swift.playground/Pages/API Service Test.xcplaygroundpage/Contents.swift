
import Combine
import XCTest
//@testable import APIService

class APIServiceTest: XCTestCase {
    private var session: URLSession!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    func testAPIService() {
        let expectation = XCTestExpectation(description: "expectation")
        let anyCancllable: AnyCancellable
        
        
        wait(for: [expectation], timeout: 10)
    }
}
