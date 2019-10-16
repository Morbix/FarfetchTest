@testable import Marvel

final class CharacterListViewingSpy: CharacterListViewing {

    private(set) var showSceneSpinnerCalled: Bool = false
    func showSceneSpinner() {
        showSceneSpinnerCalled = true
    }
}
