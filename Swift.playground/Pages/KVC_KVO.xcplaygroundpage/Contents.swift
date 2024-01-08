
/*
 KVC:
 Instead of calling any class property directly, if we call it through 'key' is called Key value coding.
 
 Example:
 UserDefault.default.value(forKey:"name")
 */
import Foundation

class River: NSObject {
    @objc dynamic var name: String
    init(_ name: String) {
        self.name = name
    }
}

let ganga = River("Ganga")
/* KVC - ganga.value(forKey: "name")! */
debugPrint(ganga.value(forKey: "name")!)

/* KVO - Observing ganga object for name property with old and new value */
let observedObject = ganga.observe(\.name, options: [.old, .new]) { river, name in
    debugPrint("Old name: \(name.oldValue!)")
    debugPrint("New name: \(name.newValue!)")
}
ganga.name = "Yamuna"

