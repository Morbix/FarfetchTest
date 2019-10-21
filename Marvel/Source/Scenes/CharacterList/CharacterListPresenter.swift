import Foundation

final class CharacterListPresenter {

    private let dataStore: CharacterListDataStore
    private let fetcher: CharacterListFetcher
    private let router: CharacterListRoutering

    init(dataStore: CharacterListDataStore,
         fetcher: CharacterListFetcher,
         router: CharacterListRoutering) {
        self.dataStore = dataStore
        self.fetcher = fetcher
        self.router = router
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

    private func askMoreCharacters() {
        guard dataStore.characters.count < dataStore.totalAvailable else { return }

        dataStore.lastCellState = .loading
        dataStore.view?.reloadData()

        fetcher.getCharacters(
            skip: dataStore.characters.count,
            completion: getCharactersHandler
        )
    }
}

// MARK: - CharacterListTableManagerDelegate

extension CharacterListPresenter: CharacterListTableManagerDelegate {

    func tableDidReachRegionAroundTheEnd() {
        if dataStore.lastCellState == .none {
            askMoreCharacters()
        }
    }

    func tableDidSelect(at index: Int) {
        guard let character = dataStore.characters[safe: index] else { return }

        router.navigateToDetail(hero: character)
    }

    func tableDidRetry() {
        if dataStore.lastCellState == .retry {
            askMoreCharacters()
        }
    }
}

// MARK: - CharacterListTableStore

extension CharacterListPresenter: CharacterListTableStore {
    var lastCellState: State {
        return dataStore.lastCellState
    }

    var heroes: [HeroCellModel] {
        dataStore.characters.map(HeroCellModel.init)
    }
}

private extension HeroCellModel {
    init(hero: Hero) {
        let totalOfContent = [
            hero.comics.count,
            hero.series.count,
            hero.stories.count,
            hero.events.count
        ].reduce(0, +)

        self.name = hero.name
        self.hasDetail = totalOfContent > 0
        self.thumbnail = hero.thumbnail
    }
}
