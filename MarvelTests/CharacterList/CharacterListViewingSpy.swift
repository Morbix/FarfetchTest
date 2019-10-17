@testable import Marvel

final class CharacterListViewingSpy: CharacterListViewing {

    func reset() {
        showSceneSpinnerCalled = false
        removeSceneSpinnerCalled = false
        hideCharactersTableCalled = false
        hideRetryOptionCalled = false
        showRetryOptionCalled = false
        showRetryCellCalled = false
    }

    private(set) var showSceneSpinnerCalled: Bool = false
    func showSceneSpinner() {
        showSceneSpinnerCalled = true
    }

    private(set) var removeSceneSpinnerCalled: Bool = false
    func removeSceneSpinner() {
        removeSceneSpinnerCalled = true
    }

    private(set) var hideCharactersTableCalled: Bool = false
    func hideCharactersTable() {
        hideCharactersTableCalled = true
    }
    private(set) var hideRetryOptionCalled: Bool = false
    func hideRetryOption() {
        hideRetryOptionCalled = true
    }

    private(set) var showRetryOptionCalled: Bool = false
    func showRetryOption() {
        showRetryOptionCalled = true
    }

    private(set) var showRetryCellCalled: Bool = false
    func showRetryCell() {
        showRetryCellCalled = true
    }
}
