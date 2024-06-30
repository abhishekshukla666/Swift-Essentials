//
//  PhotoDetailsVC.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 05/02/24.
//

import UIKit

class PhotoDetailsVC: UIViewController {
    
    let imageView = PPImageView(frame: .zero)
    var authorName = PPTitleLabel(alignment: .left)
    
    var imageDownloadUrl: String = "" {
        didSet {
            let _ = imageView.loadImage(imageDownloadUrl, { [weak self] result in
                guard let self = self else { return }
                do {
                  let image = try result.get()
                  DispatchQueue.main.async {
                      self.imageView.image = image
                      self.configureDetailView()
                  }
                } catch {
                    print("❌ \(error)")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemBackground
        configure()
}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.layoutIfNeeded()
    }
    
    private func configure() {
        view.addSubview(imageView)
        view.addSubview(authorName)
    }
    
    deinit {
        print("✅ PhotoDetailsVC Deinit")
    }
    
    fileprivate func configureDetailView() {
        if self.imageView.image?.size.width ?? 0 > self.imageView.image?.size.height ?? 0 {
            NSLayoutConstraint.activate([
                self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
                self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
                self.imageView.heightAnchor.constraint(equalToConstant: 300),
            ])
        } else {
            NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                self.imageView.heightAnchor.constraint(equalToConstant: 600),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.authorName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.authorName.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
            self.authorName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8)
        ])
    }
}
