
protocol Observer: AnyObject {
    func receive(event: String, data: String)
}

final class CustomNotificationCenter {
    
    static let shared = CustomNotificationCenter()
    private init() {}
    
    var observers = [String: [Observer]].init()
    
    func register(_ observer: Observer, for event: String) {
        guard !(observers[event]?.contains(where: { $0 === observer }) ?? false) else {
            print("All ready there \(observers)")
            return
        }
        if observers[event] != nil {
            observers[event]?.append(observer)
        } else {
            observers[event] = [observer]
        }
    }
    
    func notify(event: String, data: String) {
        guard let observers = observers[event] else { return }
        for observer in observers {
            observer.receive(event: event, data: data)
        }
    }
}

class Sender {
    func send(event: String, data: String) {
        // Notify
        CustomNotificationCenter.shared.notify(event: event, data: data)
    }
}

class Receiver: Observer {
    init() {
        // Register
        CustomNotificationCenter.shared.register(self, for: "Receiver")
    }
    func receive(event: String, data: String) {
        if event == "Receiver" {
            print("Received Event for \(event)")
        }
    }
}

class Receiver2: Observer {
    init() {
        // Register
        CustomNotificationCenter.shared.register(self, for: "Receiver")
    }
    func receive(event: String, data: String) {
        if event == "Receiver" {
            print("Received Event for \(event)")
        }
    }
}

let sender = Sender()
let ob1 = Receiver()
let ob2 = Receiver2()
sender.send(event: "Receiver", data: "100")


