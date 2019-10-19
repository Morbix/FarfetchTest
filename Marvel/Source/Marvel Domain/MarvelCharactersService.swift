import Foundation

final class MarvelCharactersService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension MarvelCharactersService: CharacterListFetcher {

    func getCharacters(_ completion: @escaping (ResultHeroes) -> Void) {

        let builder = URLRequestBuilder(with: .marvelDomainAPI)
            .appendPath("v1")
            .appendPath("public")
            .appendPath("characters")
            .appendQueryParameter("orderBy", value: "name")
            .appendQueryParameter("limit", value: 20)
            .setHTTPMethod(.get)
            .appendMarvelAuth()

        guard let request = builder.build() else {
            return completion(.failure(NSError.unexpectedFailure))
        }

        session.resumeTask(with: request, returnType: CharactersResponse.self) { taskResult in
            let finalResult: ResultHeroes

            switch taskResult {
            case .success(let response):
                finalResult = .success(response.data.results.map(Heroe.init))
            case .failure(let error):
                finalResult = .failure(error)
            }

            DispatchQueue.main.async {
                completion(finalResult)
            }
        }
    }
}

private extension Heroe {
    init(response: CharactersResponse.Hero) {
        self.name = response.name
    }
}
