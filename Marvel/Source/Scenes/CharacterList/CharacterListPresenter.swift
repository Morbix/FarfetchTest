import Foundation

struct Heroe: Equatable {}

protocol CharacterListViewing {
    func showSceneSpinner()
    func removeSceneSpinner()
    func showCharacteresTable()
    func hideCharactersTable()
    func showRetryOption()
    func hideRetryOption()
    func showRetryCell()
    func hideRetryCell()
    func showEmptyFeeback()
}

typealias ResultHeroes = Result<[Heroe], Error>
protocol CharacterListFetcher: class {
    func getCharacters(_ completion: @escaping (ResultHeroes) -> Void)
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
            guard let view = dataStore.view else { return }

            view.removeSceneSpinner()

            switch result {
            case .success(let items):
                if items.isEmpty {
                    if dataStore.characters.isEmpty {
                        view.showEmptyFeeback()
                        view.hideRetryOption()
                        view.hideCharactersTable()
                    } else {
                        view.hideRetryCell()
                    }
                } else {
                    view.showCharacteresTable()
                    dataStore.characters.append(contentsOf: items)
                }
            case .failure(_):
                if dataStore.characters.isEmpty {
                    view.hideCharactersTable()
                    view.showRetryOption()
                } else {
                    view.showRetryCell()
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
