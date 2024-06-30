//
//  ParameterEncoding.swift
//  NetworkFramework
//
//  Created by abhishek shukla on 13/05/24.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public protocol MultiPartParameterEncoder {
    func encodeMutipart(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case multipartEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .multipartEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try MultipartFileEncoder().encodeMutipart(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}

public enum NetworkError: Error, CustomStringConvertible, Equatable {
    case parametersNil
    case encodingFailed
    case missingURL
    case authentication
    case custom(message: String)
    
    public var description: String {
        switch self {
        case .parametersNil:
            return "Parameters were nil."
        case .encodingFailed:
            return "Parameter encoding failed."
        case .missingURL:
            return "URL is nil."
        case .authentication:
            return "Authentication failed."
        case .custom(let message):
            return message
        }
    }
}
