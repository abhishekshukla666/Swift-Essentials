
import Foundation

enum ServiceError: Error {
    case serverError
    case noDataError
    case parsingError
}

protocol NetworkService {
    func fetchDataList<T: Decodable>(for urlString: String, completionBlock: @escaping (Result<T?, ServiceError>) -> Void)
}


class APIService: NetworkService {
 
    let urlSession: URLSession
    
    init(session: URLSession = .shared) {
        self.urlSession = session
    }
    
    func fetchDataList<T: Decodable>(for urlString: String, completionBlock: @escaping (Result<T?, ServiceError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        self.urlSession.dataTask(with: urlRequest) { data, urlReponse, error in
            DispatchQueue.main.async {
                if error != nil {
                    completionBlock(.failure(.serverError))
                } else {
                    guard let data = data else {
                        completionBlock(.failure(.noDataError))
                        return
                    }
                    
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completionBlock(.success(response))
                    } catch {
                        completionBlock(.failure(.parsingError))
                    }
                }
            }
        }.resume()
        
    }
}
