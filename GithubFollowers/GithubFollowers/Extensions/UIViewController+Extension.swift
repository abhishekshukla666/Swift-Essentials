//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 13/01/24.
//

import UIKit

fileprivate var contentView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        contentView = UIView(frame: view.bounds)
        view.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.alpha = 0
        UIView.animate(withDuration: 0.25) { contentView.alpha = 0.80 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                contentView.removeFromSuperview()
                contentView = nil
            }
        }
    }
    
    func showEmptyStateView(with message: String, view: UIView) {
        let emptyView = GFEmptyStateView(with: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
}
