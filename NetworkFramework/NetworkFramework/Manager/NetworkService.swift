//
//  NetworkService.swift
//  NetworkFramework
//
//  Created by Abhishek Shukla on 13/05/24.
//

import Foundation

protocol NetworkServices {
    associatedtype T
    func getData(_ completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServices {
    
    var router: Router<T:>?
    init(_ router: Router) {
        self.router = router
    }
    
    func getData(_ completion: @escaping (Result<T, Error>) -> Void) {
//        router.request(forDataTask: R.Type) { data, response, error in
//            
//        }
    }
}
