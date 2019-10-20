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
        self.init(
            id: response.id,
            name: response.name,
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

        sender.sendRequest(with: request!, returnType: WrapperResponse.self) { taskResult in
            print(taskResult)
        }
    }
}
