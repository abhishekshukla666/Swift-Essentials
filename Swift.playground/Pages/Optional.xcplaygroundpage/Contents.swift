



//let num: [Any?] = ["a", 16, nil, "b", 12.32]
//
//for n in num where n is String? {
//    print(n)
//}
//for case let .some(n) in num where n is String {
//    print(n)
//}


var string1: String  // Normal
var string2: String! = "Ganga" // Implicitly unwrapped optional
var string3: String? = "Yamuna" // Optional

string1 = string2
//string1 = string3
debugPrint(string1) // print: "Ganga"
debugPrint(string2) // print: Optional("Ganga")
debugPrint(string3) // print: Optional("Yamuna")

//withUnsafePointer(to: &string1) { pointer in
//    debugPrint(pointer)
//}
//
//withUnsafePointer(to: &string2) { pointer in
//    debugPrint(pointer)
//}
//
//withUnsafePointer(to: &string3) { pointer in
//    debugPrint(pointer)
//}


enum MyOptional<T> {
    case Optional(T), Nil
    
    func unwrap() -> T {
        switch(self) {
        case .Optional(let T): return T
        case .Nil: fatalError("error while unwraping optional")
        }
    }
}

let ten = MyOptional<Any>.Nil
print(ten)
