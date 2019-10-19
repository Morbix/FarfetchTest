import Foundation

struct ErrorResponse: Decodable {
    let code: Int
    let status: String
}
