
import Foundation

protocol Observable: AnyObject {
 
    func register(observer: Observer, for event: String)
    func unRegister(observer: Observer, for event: String)
    func notify(event: String, data: Any?)
}

protocol Observer: AnyObject {
    func receive(event: String, data: Any?)
}

final class CustomNotificationCenter: Observable {
    static let shared = CustomNotificationCenter()
    private init() {}
    
    var observers: [String: [Observer]] = .init()
    
    func register(observer: Observer, for event: String) {
        guard !(observers[event]?.contains(where: { $0 === observer }) ?? false) else { return }
        if observers[event] != nil {
            observers[event]!.append(observer)
        } else {
            observers[event] = [observer]
        }
        
    }
    
    func unRegister(observer: Observer, for event: String) {
        observers[event]?.removeAll(where: { $0 === observer })
    }
    
    func notify(event: String, data: Any?) {
        guard let observers = observers[event] else { return }
        for observer in observers {
            observer.receive(event: event, data: data)
        }
    }
}

class Sender {
    func sendEvent( _ event: String, _ data: Any) {
        CustomNotificationCenter.shared.notify(event: event, data: data)
    }
}

class Observer1: Observer {
    init() {
        CustomNotificationCenter.shared.register(observer: self, for: "Event")
    }
    
    func receive(event: String, data: Any?) {
        if event == "Event", let data = data as? Int {
            print("Observer 1 received event \(event) and data: \(data)")
        }
    }
}

class Observer2: Observer {
    init() {
        CustomNotificationCenter.shared.register(observer: self, for: "Event")
    }
    
    func receive(event: String, data: Any?) {
        if event == "Event", let data = data as? Int {
            print("Observer 2 received event \(event) and data: \(data)")
        }
    }
}


let sender = Sender()
let observer1 = Observer1()
let observer2 = Observer2()
sender.sendEvent("Event", 10)
