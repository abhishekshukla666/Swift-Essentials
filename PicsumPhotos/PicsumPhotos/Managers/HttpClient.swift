//
//  HttpClient.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import UIKit

enum PPError: Error, CustomNSError {
    case urlNotValid
    case dataNotFound
    case serverError
    case jsonParsingError(message: String)
    case custom(message: String)
    
    var description: String {
        switch(self) {
        case .urlNotValid: return "Url not valid"
        case .dataNotFound: return "Data not found"
        case .serverError: return "Server Error"
        case .jsonParsingError(let message): return "Error occured during parsing: \(message)"
        case .custom(let message): return message
        }
    }
}

enum EndPoints: String {
    case baseUrl = "https://picsum.photos/v2/"
}

protocol HttpClientProtocol {
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<[T], PPError>) -> Void)
}

final class HttpClient: HttpClientProtocol {
    
    // MARK: Properties
    private var urlSession: URLSession
    
    let cache = URLCache(memoryCapacity: 250, diskCapacity: 100)
    
    // MARK: Init
    init(urlsession: URLSession) {
        self.urlSession = urlsession
    }
    
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<[T], PPError>) -> Void) {
        self.urlSession.dataTask(with: url, completionHandler: { data, response, error in
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(PPError.serverError))
                return
            }
            
            guard let data = data,
                  let object = try? JSONDecoder().decode([T].self, from: data) else {
                completion(.failure(PPError.jsonParsingError(message: "parsing error")))
                return
            }
            
            completion(.success(object))
        })
        .resume()
    }
}

