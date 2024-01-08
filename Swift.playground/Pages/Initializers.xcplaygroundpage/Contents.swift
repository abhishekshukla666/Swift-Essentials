
class Country {
    var name: String = "INDIA"
    var population: String = "130 Cr"
}

class State: Country {
    var direction: String
    init(_ direction: String) {
        self.direction = direction
        super.init()
    }
    
    convenience init(_ newDirection: String, _ population: String) {
        self.init(newDirection)
        self.direction = newDirection
        self.population = population
    }
}

//let up = State("North-East", "10 Cr")
let up = State("North-East")
debugPrint(up.direction)
debugPrint(up.population)

