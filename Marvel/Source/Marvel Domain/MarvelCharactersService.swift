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
    init(response: CharactersResponse.Hero) {
        self.name = response.name
    }
}
