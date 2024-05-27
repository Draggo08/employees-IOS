import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = URL(string: "http://localhost:3000/api")!
    private var token: String?
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginDetails = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let apiError = try? JSONDecoder().decode([String: String].self, from: data)
                completion(.failure(NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: apiError?["error"] ?? "Unknown error"])))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let token = json?["token"] as? String, let userJson = json?["user"] as? [String: Any], let userData = try? JSONSerialization.data(withJSONObject: userJson) {
                    self.token = token
                    let user = try JSONDecoder().decode(User.self, from: userData)
                    completion(.success(user))
                } else {
                    let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data returned"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func register(firstName: String, lastName: String, email: String, login: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/auth/register")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userDetails = ["firstName": firstName, "lastName": lastName, "email": email, "login": login, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: userDetails, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let apiError = try? JSONDecoder().decode([String: String].self, from: data)
                completion(.failure(NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: apiError?["error"] ?? "Unknown error"])))
                return
            }
            
            if let responseStr = String(data: data, encoding: .utf8) {
                completion(.success(responseStr))
            }
        }.resume()
    }
    
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
       guard let token = token else { return }
       
       let url = baseURL.appendingPathComponent("/employees")
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
       request.setValue(token, forHTTPHeaderField: "x-access-token")
       
       URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               completion(.failure(error))
               return
           }
           
           guard let data = data else {
               let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
               completion(.failure(error))
               return
           }
           
           do {
               let employees = try JSONDecoder().decode([Employee].self, from: data)
               completion(.success(employees))
           } catch {
               completion(.failure(error))
           }
       }.resume()
   }
    
    func addEmployee(name: String, completion: @escaping (Result<[Employee], Error>) -> Void) {
        guard let token = token else {
            completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token available"])))
            return
        }
        
        let url = baseURL.appendingPathComponent("/employees")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let employeeDetails = ["name": name]
        request.httpBody = try? JSONSerialization.data(withJSONObject: employeeDetails, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned")
                let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Received data: \(responseString)")
            }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data)
                completion(.success(employees))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    func deleteEmployee(id: String, completion: @escaping (Result<[Employee], Error>) -> Void) {
        guard let token = token else {
            completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token available"])))
            return
        }
        
        let url = baseURL.appendingPathComponent("/employees/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned")
                let error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Received data: \(responseString)")
            }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data)
                completion(.success(employees))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
