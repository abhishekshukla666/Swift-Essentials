//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 22/01/24.
//

import UIKit

struct UIHelper {
    static func configureCollectionViewFlowlayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let screenWidth             = view.bounds.width
        let padding: CGFloat        = 12
        let itemSpacing: CGFloat    = 10
        let availabelWidth          = screenWidth - (padding * 2) - (itemSpacing * 2)
        let itemWidth               = availabelWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowlayout
    }
}
