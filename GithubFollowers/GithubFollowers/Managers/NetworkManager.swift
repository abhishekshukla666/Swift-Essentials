//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 14/01/24.
//

import UIKit

protocol NetworkProtocol {
    func getFollowers(for username: String, 
                      page: Int,
                      completion: @escaping (Result<[Follower], GFError>) -> Void
    )
}


class NetworkManager: NetworkProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    let cache = NSCache<AnyObject, UIImage>()
    
    private let decoder = JSONDecoder()
    
    private let baseurl: String = "https://api.github.com"
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let followerUrl = "\(baseurl)/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: followerUrl) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.custom(errorMessage: error?.localizedDescription)))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try self.decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.custom(errorMessage: error.localizedDescription)))
            }
        }
        task.resume()
    }
    
    
}
