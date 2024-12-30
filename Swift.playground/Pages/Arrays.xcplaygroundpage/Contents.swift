
import Foundation

class ArrayTest {
    private(set) var numbers: [Int] = []
    
    func appendVal(_ val: Int) {
        numbers.append(val)
    }
    
    func readVal() -> Int {
        return self.numbers.count
    }
}

let arrayObject = ArrayTest()
let concurrentQueue = DispatchQueue(
    label: "ArrayTestQueue"
//    attributes: [.concurrent]
)

for val in 1...100 {
    concurrentQueue.async {
        arrayObject.appendVal(val)
    }
}

for _ in 1...100 {
    concurrentQueue.sync {
        print(arrayObject.readVal())
    }
}

let string = ["1", "2", "3", "4", "5"]
print(string[2...3])
