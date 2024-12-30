
import Foundation

@propertyWrapper
struct Rectangle {
    private var area = 0.0
    
    var wrappedValue: Double {
        get { return area }
        set { area = 2 * newValue }
    }
}

struct Square {
    @Rectangle var rect: Double
}

var square = Square(rect: 2.0)
square.rect = 2.0
print(square.rect)
