

protocol Observable: AnyObject {
    func register(_ receiver: Observer, _ event: String)
    func notify(_ event: String, _ data: Any?)
    func unregister(_ receiver: Observer, _ event: String)
}

protocol Observer: AnyObject {
    func unregister()
    func receive(_ event: String, _ data: Any?)
}

class NotificationCenter: Observable {
    
    static let shared = NotificationCenter()
    private init() {}
    
    var observers: [String: [Observer]] = .init()
    
    func register(_ receiver: Observer, _ event: String) {
//        guard !(observers[event]?.contains(where: { $0 === receiver }) ?? false) else { return }
        if observers[event] != nil {
            observers[event]?.append(receiver)
        } else {
            observers[event] = [receiver]
        }
    }
    
    func notify(_ event: String, _ data: Any?) {
        guard let observers = observers[event] else { return }
        for observer in observers {
            observer.receive(event, data)
        }
    }
    
    func unregister(_ receiver: Observer, _ event: String) {
        observers[event]?.removeAll(where: { $0 === receiver })
    }
}

class Sender {
    
    func send(_ event: String, _ data: String) {
        NotificationCenter.shared.notify(event, data)
    }
}

class Receiver1: Observer {
    private let receiverName: String
    init(_ receiverName: String) {
        self.receiverName = receiverName
        NotificationCenter.shared.register(self, receiverName)
    }
    
    func unregister() {
        NotificationCenter.shared.unregister(self, receiverName)
    }
    
    func receive(_ event: String, _ data: Any?) {
        print("Received for event \(event) with data \(String(describing: data))")
    }
}

class Receiver2: Observer {
    private let receiverName: String
    init(_ receiverName: String) {
        self.receiverName = receiverName
        NotificationCenter.shared.register(self, receiverName)
    }
    
    func unregister() {
        NotificationCenter.shared.unregister(self, receiverName)
    }
    
    func receive(_ event: String, _ data: Any?) {
        print("Received for event \(event) with data \(String(describing: data))")
    }
}

let sender = Sender()
let receiver1 = Receiver1("Receiver1")
let receiver2 = Receiver2("Receiver1")
sender.send("Receiver1", "100")
//sender.send("Receiver2", "100")
//receiver2.unregister()
//sender.send("Receiver2", "hello there")
