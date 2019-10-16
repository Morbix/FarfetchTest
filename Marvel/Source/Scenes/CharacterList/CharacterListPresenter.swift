import Foundation

protocol CharacterListViewing {
    func showSceneSpinner()
}

final class CharacterListPresenter {

    private let dataStore: CharacterListDataStore

    init(dataStore: CharacterListDataStore) {
        self.dataStore = dataStore
    }

    func viewDidLoad(view: CharacterListViewing) {
        dataStore.view = view
        view.showSceneSpinner()
    }
}
