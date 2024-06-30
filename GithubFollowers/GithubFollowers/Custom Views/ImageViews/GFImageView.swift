//
//  GFImageView.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 15/01/24.
//

import UIKit

class GFImageView: UIImageView {
    
    private var cache = NetworkManager.shared.cache
    
    var placeholder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        translatesAutoresizingMaskIntoConstraints = false
        image               = placeholder
    }
    
    func downloadImage(for urlString: String) {
        
        if let image = cache.object(forKey: urlString as AnyObject) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: urlString as AnyObject) 

            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
