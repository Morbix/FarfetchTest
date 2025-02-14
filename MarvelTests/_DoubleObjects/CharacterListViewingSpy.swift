@testable import Marvel

final class CharacterListViewingSpy: CharacterListViewing {

    func reset() {
        showSceneSpinnerCalled = false
        removeSceneSpinnerCalled = false
        showCharacteresTableCalled = false
        hideCharactersTableCalled = false
        hideRetryOptionCalled = false
        showRetryOptionCalled = false
        showEmptyFeebackCalled = false
        reloadDataCalled = false
    }

    private(set) var reloadDataCalled: Bool = false
    func reloadData() {
        reloadDataCalled = true
    }

    private(set) var showSceneSpinnerCalled: Bool = false
    func showSceneSpinner() {
        showSceneSpinnerCalled = true
    }

    private(set) var removeSceneSpinnerCalled: Bool = false
    func removeSceneSpinner() {
        removeSceneSpinnerCalled = true
    }

    private(set) var showCharacteresTableCalled: Bool = false
    func showCharacteresTable() {
        showCharacteresTableCalled = true
    }

    private(set) var hideCharactersTableCalled: Bool = false
    func hideCharactersTable() {
        hideCharactersTableCalled = true
    }

    private(set) var showRetryOptionCalled: Bool = false
    func showRetryOption() {
        showRetryOptionCalled = true
    }

    private(set) var hideRetryOptionCalled: Bool = false
    func hideRetryOption() {
        hideRetryOptionCalled = true
    }

    private(set) var showEmptyFeebackCalled: Bool = false
    func showEmptyFeeback() {
        showEmptyFeebackCalled = true
    }

    private(set) var hideEmptyFeedbackCalled: Bool = false
    func hideEmptyFeedback() {
        hideEmptyFeedbackCalled = true
    }

    private(set) var setSceneTitleCalled: Bool = false
    private(set) var titlePassed: String? = nil
    func setSceneTitle(_ title: String) {
        setSceneTitleCalled = true
        titlePassed = title
    }
}
