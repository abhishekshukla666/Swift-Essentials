//
//  PhotoViewModelTest.swift
//  PicsumPhotosTests
//
//  Created by Abhishek Shukla on 06/02/24.
//

import XCTest
@testable import PicsumPhotos

class PhotoViewModelTest: XCTestCase {

    var photoViewModel: PhotoViewModelProcol!
    let fetchImageExpectation = XCTestExpectation(description: "Fetched Photos")
    let fetchedWithErrorExpectation = XCTestExpectation(description: "Fetched Error")
    
    override func setUp() {
        super.setUp()
        
        photoViewModel = PhotoListViewModel(httpClient: HttpClient(urlsession: URLSession(configuration: .default)))
        photoViewModel.output = self
    }
    
    override func tearDown() {
        photoViewModel = nil
        
        super.tearDown()
    }
    
    func testfetchImageSuccess() {
        
        photoViewModel.getPhotoImage(with: "https://picsum.photos/v2/list?page=1&limit=1")
        
        wait(for: [fetchImageExpectation], timeout: 10)
    }
    
    func testFetchImageBadURL() {
        photoViewModel.getPhotoImage(with: "bad url")
        
        wait(for: [fetchedWithErrorExpectation], timeout: 10)
    }
}

extension PhotoViewModelTest: PhotoViewModelOutput {
    func returnPhotoModel(with value: [Photo]) {
        XCTAssertEqual(value.count, 1)
        fetchImageExpectation.fulfill()
    }

    
    func showError(with error: String) {
        XCTAssertNotNil(error)
        fetchedWithErrorExpectation.fulfill()
    }
}
