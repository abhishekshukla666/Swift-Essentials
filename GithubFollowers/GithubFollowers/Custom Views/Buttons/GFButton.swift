//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 12/01/24.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        
        /* Using it to show the dynamic font on different sizes for iphone settings app */
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        /* Use auto layout */
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
