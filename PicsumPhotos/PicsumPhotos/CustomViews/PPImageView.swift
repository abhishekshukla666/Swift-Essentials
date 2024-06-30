//
//  PPImageView.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import UIKit

class PPImageView: UIImageView {
    
    let emptyImage = UIImage(systemName: "photo")
    private var runningRequests = [UUID: URLSessionDataTask]()
    let cache = Utility.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        // must be in layoutsubview/loadviews
        layer.cornerRadius = 8
        clipsToBounds = true
        image = emptyImage
        contentMode = .scaleAspectFit
    }
}

extension PPImageView {
    func loadImage(_ urlString: String, _ completion: @escaping (Result<UIImage, PPError>) -> Void) -> UUID? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlNotValid))
            return nil
        }
        if let response = cache.cachedResponse(for: URLRequest(url: url)) {
            completion(.success(UIImage(data: response.data) ?? UIImage(systemName: "photo")!))
            return nil
        }
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                completion(.failure(.serverError))
                return
            }
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data), let response = response {
                let cacheResponse = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cacheResponse, for: URLRequest(url: url))
                completion(.success(image))
                return
            }

            guard let error = error else { return }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(.custom(message: error.localizedDescription)))
                return
            }
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
