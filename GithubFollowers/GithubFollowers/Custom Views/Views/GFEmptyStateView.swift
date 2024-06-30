//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 29/01/24.
//

import UIKit

class GFEmptyStateView: UIView {

 
    lazy var titleLabel = GFTitleLabel(.center, fontSize: 28)
    
    let imageView   = UIImageView(image: UIImage(named: "empty-state-logo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
        configureImageView()
    }
    
    init(with title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        configureTitleLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
        ])
    }
    
}
