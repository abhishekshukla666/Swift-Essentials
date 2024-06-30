//
//  Utility.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import Foundation

class Utility {
    
    static let shared = Utility()
    private init() {}
    
    let cache = URLCache(memoryCapacity: 250, diskCapacity: 100)
    
    static func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    
    
}
