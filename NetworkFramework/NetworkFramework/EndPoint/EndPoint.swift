//
//  PlacesEndPoint.swift
//  NetworkFramework
//
//  Created by abhishek shukla on 13/05/24.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum NetworkEnvironment {
    case UAT
    case PROD
    case DEV
}
