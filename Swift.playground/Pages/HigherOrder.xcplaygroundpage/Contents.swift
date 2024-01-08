
import Foundation

let arr = [1,2,3,4,5,6,7,8,9,10]
let alphabets = ["a", nil, "b", "c", nil, "d", nil]

extension Collection {
    
    func filterC(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for item in self {
            if isIncluded(item) {
                result.append(item)
            }
        }
        return result
    }
    
    func mapC<T>(_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        for item in self {
            result.append(transform(item))
        }
        return result
    }
    
    func compactMapC<T>(_ transform: (Element) -> T?) -> [T] {
        print("2222")
        var result = [T]()
        for item in self {
            guard let value = transform(item) else {
                continue
            }
            result.append(value)
        }
        return result
    }
    
    func reduceC<T>(_ initialValue: T, _ partialValue: (T, Element) -> T) -> T {
        var result = initialValue
        for item in self {
            result = partialValue(result, item)
        }
        return result
    }
}

let filter = arr.filterC { (num) in
    return num % 2 != 0
}

let map = arr.mapC { (num) in
    return num * 2
}


let compactMap = alphabets.compactMapC { (num) in
    print("1111")
    return num
}


let reduce = alphabets.reduce("", { partialResult, item in
    guard let item = item else { return partialResult }
    return "\(partialResult)\(String(describing: item))"
})

//print(filter)
//print(map)
print(compactMap)
//print(reduce)
