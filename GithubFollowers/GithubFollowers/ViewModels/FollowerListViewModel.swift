//
//  FollowerListViewModel.swift
//  GithubFollowers
//
//  Created by Encora on 01/05/24.
//

import Foundation

class FollowerListViewModel {
    
    var isLoading: Observable<Bool> = Observable()
    var hasMoreFollowers: Observable<Bool> = Observable()
    var followers: Observable<[Follower]> = Observable<[Follower]>()
    
    func getFollowers(username: String, page: Int) {
        if isLoading.value ?? false {
            return
        }
        isLoading.value = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .success(let followers):
                self.mapFollowersDataSource(followers)
            case .failure(let error):
                debugPrint("❌\(error)❌")
//                self.presentGFAlertOnMainThread(title: "Something went wrong", message: "\(error) 😃", buttonTitle: "Okay")
                return
            }
        }
    }
    
    func mapFollowersDataSource(_ followers: [Follower]) {
        self.followers.value = followers
    }
}
