@testable import Marvel

final class CharacterListFetcherSpy: CharacterListFetcher {

    private(set) var getCharactersCalled: Bool = false
    private(set) var getCharactersCompletionPassed: ((ResultHeroes) -> Void)?
    private(set) var skipPassed: Int? = nil
    func getCharacters(skip: Int, _ completion: @escaping (ResultHeroes) -> Void) {
        getCharactersCalled = true
        getCharactersCompletionPassed = completion
        skipPassed = skip
    }
}
