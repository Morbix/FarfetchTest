import Foundation

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
        fetcher.getCharacters(skip: 0, completion: getCharactersHandler)
    }

    private func getCharactersHandler(result: ResultHeroes) {
        guard let view = dataStore.view else { return }

        view.removeSceneSpinner()

        switch result {
        case .success(let (items, total)):
            dataStore.totalAvailable = total
            dataStore.lastCellState = .none
            view.hideRetryOption()

            if items.isEmpty && dataStore.characters.isEmpty {
                view.showEmptyFeeback()
                view.hideCharactersTable()
            } else {
                view.showCharacteresTable()
                dataStore.characters.append(contentsOf: items)
            }
        case .failure:
            if dataStore.characters.isEmpty {
                view.hideCharactersTable()
                view.showRetryOption()
            } else {
                dataStore.lastCellState = .retry
            }
        }

        view.reloadData()
    }

    private func setupInitialState() {
        dataStore.view?.setSceneTitle("marvel_heroes".localized())
        dataStore.view?.hideRetryOption()
        dataStore.view?.hideCharactersTable()
        dataStore.view?.showSceneSpinner()
        dataStore.view?.hideEmptyFeedback()
    }
}

// MARK: - CharacterListTableManagerDelegate

extension CharacterListPresenter: CharacterListTableManagerDelegate {

    func tableDidReachRegionAroundTheEnd() {

        if dataStore.lastCellState == .none,
            dataStore.characters.count < dataStore.totalAvailable {

            dataStore.lastCellState = .loading
            dataStore.view?.reloadData()

            fetcher.getCharacters(
                skip: dataStore.characters.count,
                completion: getCharactersHandler
            )
        }
    }
}
