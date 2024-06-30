//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 12/01/24.
//

import UIKit

class FavoritesListVC: UIViewController {

    let pinkView    = UIView()
    private let flexiLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12)
        label.tintColor = .red
        label.text = "Auto layout testing"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    let greenView   = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Favourites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
        configureLeftView()
        configureLabel()
        configureRightView()
    }

    private func configureLeftView() {
        
        pinkView.translatesAutoresizingMaskIntoConstraints  = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        flexiLabel.translatesAutoresizingMaskIntoConstraints     = false
        view.addSubview(pinkView)
        view.addSubview(flexiLabel)
        view.addSubview(greenView)
        pinkView.backgroundColor = .systemPink
        greenView.backgroundColor = .systemGreen
        flexiLabel.backgroundColor = .systemCyan
        NSLayoutConstraint.activate([
            pinkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            pinkView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            pinkView.heightAnchor.constraint(equalToConstant: 40),
            pinkView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
    }

    private func configureLabel() {
        
        NSLayoutConstraint.activate([
            flexiLabel.leadingAnchor.constraint(equalTo: pinkView.trailingAnchor, constant: 8),
            flexiLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            flexiLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        flexiLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func configureRightView() {
        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: flexiLabel.trailingAnchor, constant: 12),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            greenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            greenView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
