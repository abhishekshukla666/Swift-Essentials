//
//  PhotoViewOrientationTest.swift
//  PicsumPhotosTests
//
//  Created by Abhishek Shukla on 07/02/24.
//

import XCTest
@testable import PicsumPhotos

final class PhotoViewOrientationTest: XCTestCase {

    var imageView = UIImageView(frame: .zero)
    
    override func setUp() {
        super.setUp()
        imageView.image = UIImage(named: "graps")
    }
    
    func testImagePotraitSucess() {
        
        guard let size = imageView.image?.size else {
            XCTAssertThrowsError("failure")
            return
        }
        XCTAssertEqual(size.width < size.height, true)
    }

    
    func testImageLandscapeSucess() {
        guard let size = imageView.image?.size else {
            XCTAssertThrowsError("failure")
            return
        }
        XCTAssertEqual(size.width > size.height, false)
    }

    override func tearDown() {
        imageView.image = nil
        super.tearDown()
    }
}
