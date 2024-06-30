
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

/* Custom Initializer */
enum NetworkError: Error {
    
    case noInternet
    case serverNotFound
    case unauthorized
    case internalServerError
    case customError(message: String)
    
    init(errorCode: Int) {
        switch errorCode {
        case 401:
            self = .unauthorized
        case 404:
            self = .serverNotFound
        case 500:
            self = .internalServerError
        default:
            self = .customError(message: "Unknown error with code \(errorCode)")
        }
    }
}

let error = NetworkError(errorCode: 404)
let customError = NetworkError(errorCode: 403)

/* Enum Methods */
extension NetworkError {
    func errorMessage() -> String {
        switch self {
        case .noInternet:
            return "No internet connection."
        case .serverNotFound:
            return "Server not found."
        case .unauthorized:
            return "Unauthorized access."
        case .internalServerError:
            return "Internal server error."
        case .customError(message: let message):
            return "Unknown error with message \(message)"
        }
    }
}
