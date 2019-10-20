import Foundation

struct ContentResponse: Decodable {
    let data: Data
}

extension ContentResponse {
    struct Data: Decodable {
        let offset: Int
        let total: Int
        let count: Int
        let results: [Item]
    }
}

extension ContentResponse.Data {
    struct Item: Decodable {
        let id: Int
        let name: String
        let description: String?
    }
}
