@testable import Marvel

final class CharacterDetailFetcherSpy: CharacterDetailFetcher {

    private(set) var getContentCalled: Bool = false
    private(set) var typePassed: ContentType? = nil
    private(set) var getContentCompletionPassed: ((ResultContent) -> Void)?
    private(set) var characterIdPassed: Int? = nil
    func getContent(type: ContentType, characterId: Int, completion: @escaping (ResultContent) -> Void) {
        getContentCalled = true
        typePassed = type
        characterIdPassed = characterId
        getContentCompletionPassed = completion
    }
}
