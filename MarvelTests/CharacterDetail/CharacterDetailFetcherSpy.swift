@testable import Marvel

final class CharacterDetailFetcherSpy: CharacterDetailFetcher {

    private(set) var getContentCalled: Bool = false
    private(set) var typePassed: ContentType? = nil
    private(set) var getContentCompletionPassed: ((ResultContent) -> Void)?
    func getContent(type: ContentType, completion: @escaping (ResultContent) -> Void) {
        getContentCalled = true
        typePassed = type
        getContentCompletionPassed = completion
    }
}
