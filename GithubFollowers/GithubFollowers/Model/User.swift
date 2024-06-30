//
//  User.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 14/01/24.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: Int
    var following: Int
    var followers: Int
    var createdAt: String
}
