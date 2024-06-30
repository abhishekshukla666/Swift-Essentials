
//
//  MockHttpClient.swift
//  PicsumPhotosTests
//
//  Created by Abhishek Shukla on 06/02/24.
//

import Foundation

final class MockHtppClient: HttpClientProtocol, Mockable {
    func fetch<T>(url: URL, completion: @escaping (Result<[T], PPError>) -> Void) where T : Decodable, T : Encodable {
        
        return loadJson(filename: "PhotoResponse",
                        extensionType: .json,
                        type: T.self, completion: completion)
    }
    
}
