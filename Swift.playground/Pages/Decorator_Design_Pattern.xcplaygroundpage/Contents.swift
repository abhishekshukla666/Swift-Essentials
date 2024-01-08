
protocol Cake {
    var name: String { get }
    var price: Double { get }
}

class RedVallvet: Cake {
    var name: String {
        return "Red Vallvet"
    }
    
    var price: Double {
        return 1000
    }
}

class CheeseBread: Cake {
    var name: String {
        return "Cheese Bread"
    }
    
    var price: Double {
        return 2000
    }
}

/* Decorator */
class ChocoSprinklet: Cake {
    
    private let cake: Cake
    init(cake: Cake) {
        self.cake = cake
    }
    
    var name: String {
        return cake.name + "Choco sprinklet"
    }
    
    var price: Double {
        return cake.price + 100
    }
    
}

let redVallvet = RedVallvet()
let cheeseCake = CheeseBread()
let chocoRedVallvet = ChocoSprinklet(cake: cheeseCake)
debugPrint(chocoRedVallvet.name)

