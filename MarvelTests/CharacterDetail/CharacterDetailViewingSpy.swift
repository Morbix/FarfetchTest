@testable import Marvel

final class CharacterDetailViewingSpy: CharacterDetailViewing {

    private(set) var setSceneTitleCalled: Bool = false
    private(set) var titlePassed: String? = nil
    func setSceneTitle(_ title: String) {
        setSceneTitleCalled = true
        titlePassed = title
    }
}
