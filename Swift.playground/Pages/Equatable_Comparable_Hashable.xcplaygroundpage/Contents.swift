
/*
class River: Equatable {
    
    let name: String
    let country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
    
    /* Do not need this method in case of struct */
    static func == (lhs: River, rhs: River) -> Bool {
        return lhs.country == rhs.country
    }
}

let ganga = River(name: "Ganaga", country: "India", length: 100)
let yamuna = River(name: "Yamuna", country: "India", length: 500)

if ganga == yamuna {
    debugPrint("Ganga's length is smaller than Yamuna")
}
*/

/*
class River: Comparable {
    static func < (lhs: River, rhs: River) -> Bool {
        return lhs.length < rhs.length
    }
    
    let name: String
    let country: String
    let length: Int // KM
    
    init(name: String, country: String, length: Int) {
        self.name = name
        self.country = country
        self.length = length
    }
    
    static func == (lhs: River, rhs: River) -> Bool {
        return lhs.country == rhs.country
    }
}

let ganga = River(name: "Ganaga", country: "India", length: 100)
let yamuna = River(name: "Yamuna", country: "India", length: 500)
*/
class River: Hashable {
    
    let name: String
    let country: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(country)
    }
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
    
    static func == (lhs: River, rhs: River) -> Bool {
        return lhs.country == rhs.country
    }
}

let ganga = River(name: "Ganaga", country: "India")
let yamuna = River(name: "Yamuna", country: "India")

print(ganga.hashValue)
print(yamuna.hashValue)
