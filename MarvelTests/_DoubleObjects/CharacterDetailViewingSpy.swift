@testable import Marvel

final class CharacterDetailViewingSpy: CharacterDetailViewing {

    func reset() {
        setSceneTitleCalled = false
        reloadDataCalled = false
    }

    private(set) var setSceneTitleCalled: Bool = false
    private(set) var titlePassed: String? = nil
    func setSceneTitle(_ title: String) {
        setSceneTitleCalled = true
        titlePassed = title
    }

    private(set) var reloadDataCalled: Bool = false
    func reloadData() {
        reloadDataCalled = true
    }
}
