
protocol GenerateBaseUrl {
    func baseUrl() -> String
}

class Production: GenerateBaseUrl {
    func baseUrl() -> String {
        return "https://prod.com"
    }
}

class Dev: GenerateBaseUrl {
    func baseUrl() -> String {
        return "https://dev.com"
    }
}

protocol BaseUrlFactory {
    func baseUrl() -> String
}
class UrlFactory {
    enum Environment {
        case prod
        case dev
    }
    
    private let env: Environment
    init(env: Environment) {
        self.env = env
    }
    
    func baseUrl() -> String {
        switch env {
        case .dev:
            return Dev().baseUrl()
        case .prod:
            return Production().baseUrl()
        }
    }
}

let url = UrlFactory(env: .dev)
debugPrint(url.baseUrl())
