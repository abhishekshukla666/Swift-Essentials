
enum Weeks: CaseIterable {
    static var allCases: [Weeks] {
        return [
            .monday, .tuesday, .wednesday, .thursday, .friday, .saturday,
            .sunday(fun: "Holiday")
        ]
    }
    
    
    /* case monday, tuesday, wednesday, thursday, friday, saturday, sunday */
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday(fun: String)
    
}

for item in Weeks.allCases {
    print(item)
}
