import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = "" // Переименованная переменная login
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var employees: [Employee] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        NetworkService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.isAuthenticated = true
                    self?.currentUser = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func register() {
        NetworkService.shared.register(firstName: firstName, lastName: lastName, email: email, login: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.login()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchEmployees() {
        NetworkService.shared.fetchEmployees { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self?.employees = employees
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func addEmployee(name: String) {
        NetworkService.shared.addEmployee(name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self?.employees = employees
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func deleteEmployee(id: String) {
        NetworkService.shared.deleteEmployee(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self?.employees = employees
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
