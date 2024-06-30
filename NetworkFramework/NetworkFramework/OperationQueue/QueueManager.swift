//
//  QueueManager.swift
//  NetworkFramework
//
//  Created by Abhishek Shukla on 13/05/24.
//

import Foundation

class QueueManager {
    
    static let shared = QueueManager()
    private init() {}
    
    lazy var networkQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .default
        return queue
    }()
    
    func enqueueOperation(_ operation: Operation) {
        networkQueue.addOperation(operation)
    }
}
