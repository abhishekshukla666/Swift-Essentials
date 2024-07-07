//
//  Observable.swift
//  GithubFollowers
//
//  Created by Encora on 01/05/24.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            self.listener?(self.value)
        }
    }
    
    init(value: T? = nil) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        self.listener = listener
        listener(value)
    }
}
