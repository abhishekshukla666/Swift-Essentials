
// How to create a subscription?
// What does a publisher wihout a subscription?
// What does data stream mean?

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// AnyCancellable wihout '?'
var subscribtion: AnyCancellable? = Timer.publish(every: 20.0, on: .main, in: .common)
    .autoconnect()
    ///update data
    .scan(0, { count, _ in
        return count + 1
    })
    ///add condition
    .filter { count in
        return count < 10
    }
    .sink { completion in
        print("data steam completion \(completion)")
    } receiveValue: { timestamp in
        print("received value: \(timestamp)")
    }

/// How to cancel a subscription
DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
//    subscribtion.cancel()
    subscribtion = nil
}

//: [Next](@next)
