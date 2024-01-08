
import Foundation

class Logger {
    static let shared = Logger()
    private init() {}
    
    private(set) var dict = [String: String]()
    
    
    func writeLog(_ key: String, _ value: String) {
        dict[key] = value
        
    }
    
    func readLog(key: String) -> String {
        return dict[key, default: ""]
    }
}

let log = Logger.shared
let customQueue = DispatchQueue(
    label: "CustomQueue",
    attributes: [.concurrent]
)
for i in 0...100 {
    customQueue.async(flags: [.barrier]) {
        log.writeLog("Key: \(i)", "Value: \(i)")
        let value = log.readLog(key: "Key: \(i)")
        debugPrint(value)
    }
}
    
