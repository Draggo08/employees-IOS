import Foundation

struct Employee: Identifiable, Codable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
