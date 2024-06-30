
import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listner?(self.value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listner: ((T?) -> Void)?
    
    func bind(_ completion: @escaping ((T?) -> Void)) {
        self.listner(value)
        self.listner = completion
        
    }
}
