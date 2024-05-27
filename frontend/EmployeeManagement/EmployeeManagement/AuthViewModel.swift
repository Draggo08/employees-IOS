import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = "" // Переименуем 'login' в 'username'
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
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
        NetworkService.shared.register(firstName: firstName, lastName: lastName, email: email, login: username, password: password) { [weak self] result in // Здесь также должно быть 'username'
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.login() // Вызов метода 'login'
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
