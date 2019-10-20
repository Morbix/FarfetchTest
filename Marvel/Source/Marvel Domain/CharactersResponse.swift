import Foundation

struct CharactersResponse: Decodable {
    let data: Data
}

extension CharactersResponse {
    struct Data: Decodable {
        let offset: Int
        let total: Int
        let count: Int
        let results: [Item]
    }
}

extension CharactersResponse.Data {
    struct Item: Decodable {
        let id: Int
        let name: String
        let description: String?
        let comics: Content
        let series: Content
        let stories: Content
        let events: Content
    }
}

extension CharactersResponse.Data {
    struct Content: Decodable {
        let items: [Item]
    }
}

extension CharactersResponse.Data.Content {
    struct Item: Decodable {
        let name: String
    }
}
