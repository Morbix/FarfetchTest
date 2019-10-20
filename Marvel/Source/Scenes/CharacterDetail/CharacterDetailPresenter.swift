import Foundation

protocol CharacterDetailViewing {
}

final class CharacterDetailPresenter {

    private let dataStore: CharacterDetailDataStore

    init(dataStore: CharacterDetailDataStore) {
        self.dataStore = dataStore
    }

    func viewDidLoad(view: CharacterDetailViewing) {
        dataStore.view = view
    }
}
