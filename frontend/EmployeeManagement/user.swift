import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let login: String
    let password: String?
}
