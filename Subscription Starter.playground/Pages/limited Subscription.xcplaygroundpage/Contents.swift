//: [Previous](@previous)

import UIKit
import Combine


var foodbank: Publishers.Sequence<[String], Never> = ["apple", "bread", "orange", "milk"].publisher
//
//let subscription = foodbank.sink { (completion) in
//    print("completion: \(completion)")
//} receiveValue: { foodItem in
//    print("receive item \(foodItem)")
//}

//foodbank.append("banana")


var timer = Timer.publish(every: 1.0, on: .main, in: .common)
    .autoconnect()

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: .init())

let subscription = foodbank.zip(timer)
    .tryMap({ (foodItem, timestamp) in
        return "\(foodItem) at \(timestamp)"
    })
    .sink { (completion) in
        switch completion {
        case .finished:
            print("completion: \(completion)")
        case .failure(let error):
            print()
        }
} receiveValue: { (result) in
    print("receive item \(result)")
}


//: [Next](@next)
