
/* Opaque Types */
//protocol Car {
//    associatedtype Idetifier
//    var id: Idetifier { get }
//}
//
//struct BMW: Car {
//    var id: String
//    init(_ id: String) {
//        self.id = id
//    }
//}
//
//struct Honda: Car {
//    var id: Int
//    init(_ id: Int) {
//        self.id = id
//    }
//}
//
//func printCar() -> some Car {
//    if Bool.random() {
//        return BMW("BMW R8")
//    } else {
//        return Honda(123)
//    }
//}


protocol River {
    associatedtype T
    var name: T { get set }
}

struct Ganga: River {
    var name: String = "Ganga"
}

struct Yamuna: River {
    var name: String = "Yamuna"
}

let ganga = Ganga()
let yamuna = Yamuna()

func getRiver() -> some River {
    return ganga
}

print(getRiver() as? River)

