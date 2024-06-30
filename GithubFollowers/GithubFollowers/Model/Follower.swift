//
//  Follower.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 14/01/24.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}


