import Foundation

struct Heroe {}

protocol CharacterListViewing {
    func showSceneSpinner()
    func removeSceneSpinner()
    func hideCharactersTable()
    func hideRetryOption()
    func showRetryOption()
    func showRetryCell()
}

protocol CharacterListFetcher: class {
    func getCharacters(_ completion: @escaping (Result<[Heroe], Error>) -> Void)
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

        setupInitialState()

        fetcher.getCharacters { [dataStore] result in
            dataStore.view?.removeSceneSpinner()

            switch result {
            case .success(_):
                break
            case .failure(_):
                if dataStore.characters.isEmpty {
                    dataStore.view?.hideCharactersTable()
                    dataStore.view?.showRetryOption()
                } else {
                    dataStore.view?.showRetryCell()
                }
            }
        }
    }

    private func setupInitialState() {
        dataStore.view?.hideRetryOption()
        dataStore.view?.hideCharactersTable()
        dataStore.view?.showSceneSpinner()
    }
}
