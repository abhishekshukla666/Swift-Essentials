
import Foundation

struct Person {
    var firstName: String
    var lastName: String
    var age: Int
    var isRegistered: Bool
}


class ParsePerson {
    
    static let shared = ParsePerson()
    private init() {}
    
    private(set) var persons = [Person]()
    
    func loadCSV() {
        guard let filePath = Bundle.main.path(forResource: "data", ofType: "csv") else { return }
        
        // convert the data into long string
        var stringData = ""
        do {
            stringData = try String(contentsOfFile: filePath)
        } catch {
            print("❌ \(error)")
            return
        }
        
        var rows = stringData.components(separatedBy: "\n")
        rows.removeFirst()
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            guard columns.count == 4 else { return }
            let firstName   = columns[0]
            let lastName    = columns[1]
            let age         = columns[2]
            let restrictred = columns[3]
            
            let person = Person(firstName: firstName, lastName: lastName, age: age, isRegistered: restrictred)
            persons.append(person)
        }
    }
}
