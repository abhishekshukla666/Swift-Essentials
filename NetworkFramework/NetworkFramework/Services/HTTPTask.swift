//
//  HTTPTask.swift
//  NetworkFramework
//
// Created by Abhishek Shukla on 13/05/24.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
//    case requestParameters(bodyParameters: Parameters?,
//        bodyEncoding: ParameterEncoding,
//        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
}
