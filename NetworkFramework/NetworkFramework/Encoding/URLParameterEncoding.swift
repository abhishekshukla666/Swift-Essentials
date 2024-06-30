//
//  URLParameterEncoding.swift
//  NetworkFramework
//
//  Created by abhishek shukla on 13/05/24.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}

public struct MultipartFileEncoder: MultiPartParameterEncoder {
    public func encodeMutipart(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let boundary = urlRequest.allHTTPHeaderFields?["boundary"] ?? "--"
        let httpBody = NSMutableData()
        guard let fileName = parameters["fileName"] as? String else { return }
        guard let fileType = parameters["fileType"] as? String else { return }
        guard let mimeType = parameters["mimeType"] as? String else { return }
        guard let fileData = parameters["fileData"] as? Data else { return }
        httpBody.append(convertFileData(fileName: fileName,
                                        mimeType: mimeType,
                                        fileType: fileType,
                                        fileData: fileData, using: boundary))
        
        urlRequest.httpBody = httpBody as Data
//        print(String(data: httpBody as Data, encoding: .utf8)!)
    }
    
    fileprivate func convertFileData(fileName: String, mimeType: String, fileType: String, fileData: Data, using boundary: String) -> Data {
        let body = NSMutableData()
        let lineBreak = "\r\n"
        let boundaryPrefix = "--\(boundary)\r\n"
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"\(fileName)\(fileType)\"\r\n")
        debugPrint(fileName, mimeType)
        body.appendString("Content-Type: \("\(mimeType)")\r\n\r\n")
        body.append(fileData)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\(lineBreak)")
        return body as Data
        
    }
}
