import Foundation

struct CharactersResponse: Decodable {
    let data: Data
}

extension CharactersResponse {
    struct Data: Decodable {
        let offset: Int
        let total: Int
        let count: Int
        let results: [Hero]
    }
}

extension CharactersResponse {
    struct Hero: Decodable {
        let id: Int
        let name: String
    }
}
