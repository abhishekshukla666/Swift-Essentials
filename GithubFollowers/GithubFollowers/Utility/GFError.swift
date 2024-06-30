//
//  GFError.swift
//  GithubFollowers
//
//  Created by Abhishek Shukla on 15/01/24.
//

import Foundation
enum GFError: Error {
    case apiError, invalidEndpoint, invalidResponse, noData, serializationError, custom( errorMessage: String?)
    
    var localizedDescription: String {
        switch self {
        case .apiError: "Network error"
        case .invalidEndpoint: "Invalid Endpoint"
        case .invalidResponse: "Invalid Response"
        case .noData: "No data availabel"
        case .serializationError: "Data could not parse"
        case .custom(let errorMessage): errorMessage ?? "no message was given"
        }
    }
}
