//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 13/01/24.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var viewModel: FollowerListViewModel = FollowerListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        viewModel.getFollowers(username: userName, page: page)
        configureDataSource()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoadingView()
                } else {
                    self.hideLoadingView()
                }
            }
        }
        
        viewModel.followers.bind { [weak self] followers in
            guard let self = self, let followers = followers else { return }
            if followers.count < 100 { self.hasMoreFollowers = false }
            self.followers.append(contentsOf: followers)
            if followers.isEmpty {
                DispatchQueue.main.async {
                    let message = "This user does not have any followers. Go follow them 😔"
                    self.showEmptyStateView(with: message, view: self.collectionView)
                    return
                }
            }
            self.updateData()
        }
    }
    
    private func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = userName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.configureCollectionViewFlowlayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follwer in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseId, for: indexPath) as! FollowersCell
            cell.set(follower: follwer)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        print(offsetY)
        print(contentHeight)
        print(height)
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            viewModel.getFollowers(username: userName, page: page)
        }
    }
}
