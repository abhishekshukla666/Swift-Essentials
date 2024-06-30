//
//  GFSubTitleLabel.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 13/01/24.
//

import UIKit

class GFSubTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(_ textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font                        = UIFont.preferredFont(forTextStyle: .body)
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byWordWrapping
    }
}
