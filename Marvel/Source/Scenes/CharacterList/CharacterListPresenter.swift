import Foundation

struct Heroe {}

protocol CharacterListViewing {
    func showSceneSpinner()
}

protocol CharacterListFetcher: class {
    func getCharacters(_ completion: @escaping (Result<Heroe, Error>) -> Void)
}

final class CharacterListPresenter {

    private let dataStore: CharacterListDataStore
    private let fetcher: CharacterListFetcher

    init(dataStore: CharacterListDataStore,
         fetcher: CharacterListFetcher) {
        self.dataStore = dataStore
        self.fetcher = fetcher
    }

    func viewDidLoad(view: CharacterListViewing) {
        dataStore.view = view

        view.showSceneSpinner()
        fetcher.getCharacters { _ in }
    }
}
