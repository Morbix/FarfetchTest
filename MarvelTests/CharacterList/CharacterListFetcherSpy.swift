@testable import Marvel

final class CharacterListFetcherSpy: CharacterListFetcher {

    private(set) var getCharactersCalled: Bool = false
    private(set) var getCharactersCompletionPassed: ((ResultHeroes) -> Void)? = nil
    func getCharacters(_ completion: @escaping (ResultHeroes) -> Void) {
        getCharactersCalled = true
        getCharactersCompletionPassed = completion
    }
}
