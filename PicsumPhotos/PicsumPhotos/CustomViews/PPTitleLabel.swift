//
//  PPTitleLabel.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import UIKit

class PPTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment: NSTextAlignment) {
        super.init(frame: .zero)
        textAlignment = alignment
        configure()
    }
    
    private func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .title1)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
