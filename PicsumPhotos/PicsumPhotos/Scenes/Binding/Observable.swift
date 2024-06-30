//
//  Observable.swift
//  PicsumPhotos
//
//  Created by Encora on 20/05/24.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            listen?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listen: ((T) -> Void)?
    
    func bind(_ closure: @escaping ((T) -> Void)) {
        self.listen = closure
        closure(value)
        
    }
}
