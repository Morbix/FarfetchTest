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

extension MarvelCharactersService: CharacterListFetcher {

    func getCharacters(_ completion: @escaping (ResultHeroes) -> Void) {

        let request = URLRequestBuilder(with: .marvelDomainAPI)
            .appendPath("v1")
            .appendPath("public")
            .appendPath("characters")
            .appendQueryParameter("orderBy", value: "name")
            .appendQueryParameter("limit", value: 20)
            .setHTTPMethod(.get)
            .appendMarvelAuth()
            .build()

        sender.sendRequest(with: request!, returnType: CharactersResponse.self) { taskResult in
            let finalResult: ResultHeroes

            switch taskResult {
            case .success(let response):
                finalResult = .success(response.data.results.map(Hero.init))
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
    init(response: CharactersResponse.Hero) {
        self.name = response.name
    }
}
