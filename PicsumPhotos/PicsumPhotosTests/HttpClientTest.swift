//
//  HttpClientTest.swift
//  PicsumPhotosTests
//
//  Created by Abhishek Shukla on 06/02/24.
//

import XCTest
@testable import PicsumPhotos

final class HttpClientTest: XCTestCase, Mockable {
    
    var image = UIImage()
    var urlSession: URLSession!
    var httpClient: HttpClient! /* For Mock - MockHtppClient! */
    let reqURL = URL(string: "https://picsum.photos/v2/list?page=1&limit=1")!
    
    
    let mockString = 
    """
        [
            {
                "id": "0",
                "author": "Alejandro Escamilla",
                "width": 5000,
                "height": 3333,
                "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
                "download_url": "https://picsum.photos/id/0/5000/3333"
              }
        ]
    """
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        
        httpClient = HttpClient(urlsession: urlSession)
//        httpClient = MockHtppClient()
        image = UIImage()
    }
    
    override func tearDown() {
        urlSession = nil
        httpClient = nil
        
        super.tearDown()
    }
    
    func test_GetPhoto_Success() throws {
        
        let response = HTTPURLResponse(url: reqURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        httpClient.fetch(url: reqURL) { (response: Result<[Photo], PPError>) in
            switch response {
            case .success(let photoModel):
                XCTAssertEqual(photoModel.first?.download_url, "https://picsum.photos/id/0/5000/3333")
                XCTAssertEqual(photoModel.count, 1)
                
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test_getPhoto_BadResponse() throws {
        let response = HTTPURLResponse(url: reqURL,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        httpClient.fetch(url: reqURL) { (response: Result<[Photo], PPError>) in
            switch response {
            case .success:
                XCTAssertThrowsError("Fatal Error")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    
    func test_GetPhoto_EncodingError() {
        let response = HTTPURLResponse(url: reqURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        httpClient.fetch(url: reqURL) { (response: Result<[[Photo]], PPError>) in
            switch response {
            case .success:
                XCTAssertThrowsError("Fatal Error")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
