//
//  PPItemCell.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import UIKit

class PPItemCell: UITableViewCell {
    
    static let reuse = "PPItemCellIdentifier"
    var onReuse: () -> Void = {}
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 16.0
        view.layer.borderColor = UIColor.lightText.cgColor
        view.layer.borderWidth = 2.0
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    var photoImage   = PPImageView(frame: .zero)
    let titleLabel  = PPTitleLabel(alignment: .right)
    let authorLabel  = PPTitleLabel(alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhoto(with photo: Photo) {
        titleLabel.text = photo.id
        authorLabel.text = photo.author
        let token = photoImage.loadImage(photo.download_url) { result in
          do {
            let image = try result.get()
            DispatchQueue.main.async {
                self.photoImage.image = image
            }
          } catch {
              print("❌ \(error)")
          }
        }

        self.onReuse = { [weak self] in
            guard let self = self else { return }
            if let token = token {
                self.photoImage.cancelLoad(token)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        photoImage.image = photoImage.emptyImage
    }
    
    private func configureCell() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(photoImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            
            photoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            photoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            photoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            photoImage.heightAnchor.constraint(equalToConstant: 240),
            
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 0),
            authorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
