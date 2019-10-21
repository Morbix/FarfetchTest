import Foundation

protocol RequestSender {
    func sendRequest<T: Decodable>(with request: URLRequest,
                                   returnType: T.Type,
                                   completion: @escaping (Result<T, Error>) -> Void)
}

final class MarvelCharactersService {
    private let sender: RequestSender

    init(sender: RequestSender = URLSession.shared) {
        self.sender = sender
    }
}

// MARK: - CharacterListFetcher

extension MarvelCharactersService: CharacterListFetcher {

    func getCharacters(skip: Int = 0, completion: @escaping (ResultHeroes) -> Void) {

        let request = URLRequestBuilder(with: .marvelDomainAPI)
            .appendPath("v1")
            .appendPath("public")
            .appendPath("characters")
            .appendQueryParameter("orderBy", value: "name")
            .appendQueryParameter("limit", value: 20)
            .appendQueryParameter("offset", value: skip)
            .setHTTPMethod(.get)
            .appendMarvelAuth()
            .build()

        sender.sendRequest(with: request!, returnType: CharactersResponse.self) { taskResult in
            let finalResult: ResultHeroes

            switch taskResult {
            case .success(let response):
                let data = response.data
                finalResult = .success((data.results.map(Hero.init), data.total))
            case .failure(let error):
                finalResult = .failure(error)
            }

            DispatchQueue.main.async {
                completion(finalResult)
            }
        }
    }
}

private extension Hero {
    
    convenience init(response: CharactersResponse.Data.Item) {
        let thumbnail = response.thumbnail.map {
            "\($0.path).\($0.extension)".replacingOccurrences(of: "http://", with: "https://")
        }
        self.init(
            id: response.id,
            name: response.name,
            thumbnail: thumbnail,
            comics: response.comics.items.map(Content.init),
            series: response.series.items.map(Content.init),
            stories: response.stories.items.map(Content.init),
            events: response.events.items.map(Content.init)
        )
    }
}

private extension Content {
    init(response: CharactersResponse.Data.Content.Item) {
        self.init(name: response.name)
    }
}

// MARK: - CharacterDetailFetcher

extension MarvelCharactersService: CharacterDetailFetcher {
    func getContent(type: ContentType, characterId: Int, completion: @escaping (ResultContent) -> Void) {

        let request = URLRequestBuilder(with: .marvelDomainAPI)
            .appendPath("v1")
            .appendPath("public")
            .appendPath("characters")
            .appendPath("\(characterId)")
            .appendPath(type.rawValue)
            .appendQueryParameter("limit", value: 20)
            .setHTTPMethod(.get)
            .appendMarvelAuth()
            .build()

        sender.sendRequest(with: request!, returnType: ContentResponse.self) { taskResult in
            let finalResult: ResultContent

            switch taskResult {
            case .success(let response):
                finalResult = .success(response.data.results.map(Content.init))
            case .failure(let error):
                finalResult = .failure(error)
            }

            DispatchQueue.main.async {
                completion(finalResult)
            }
        }
    }
}

private extension Content {
    init(response: ContentResponse.Data.Item) {
        self.init(name: response.title, description: response.description)
    }
}
