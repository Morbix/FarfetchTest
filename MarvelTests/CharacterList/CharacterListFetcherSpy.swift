@testable import Marvel

final class CharacterListFetcherSpy: CharacterListFetcher {

    private(set) var getCharactersCalled: Bool = false
    private(set) var getCharactersCompletionPassed: ((Result<[Heroe], Error>) -> Void)? = nil
    func getCharacters(_ completion: @escaping (Result<[Heroe], Error>) -> Void) {
        getCharactersCalled = true
        getCharactersCompletionPassed = completion
    }
}
