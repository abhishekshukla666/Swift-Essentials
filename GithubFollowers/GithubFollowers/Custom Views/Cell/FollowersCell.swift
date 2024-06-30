//
//  FollowersCell.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 15/01/24.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    
    static let reuseId = "FollowersCell"
    let avatarImageView = GFImageView(frame: .zero)
    let avatarTitle     = GFTitleLabel(.center, fontSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        avatarTitle.text = follower.login
        avatarImageView.downloadImage(for: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(avatarTitle)
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        
            avatarTitle.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            avatarTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


