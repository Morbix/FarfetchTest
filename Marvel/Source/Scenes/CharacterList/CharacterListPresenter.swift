import Foundation

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
    func hideEmptyFeedback()
    func includeCharacters(_ characters: [HeroCellModel])
    func setSceneTitle(_ title: String)
    func showLoadingCell()
}

typealias ResultHeroes = Result<[Hero], Error>
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
                view.hideRetryCell()
                view.hideRetryOption()

                if items.isEmpty && dataStore.characters.isEmpty {
                    view.showEmptyFeeback()
                    view.hideCharactersTable()
                } else {
                    view.showCharacteresTable()
                    dataStore.characters.append(contentsOf: items)
                    view.includeCharacters(items.map(HeroCellModel.init))
                }
            case .failure:
                if dataStore.characters.isEmpty {
                    view.hideCharactersTable()
                    view.showRetryOption()
                } else {
                    view.showRetryCell()
                }
            }
        }
    }

    func tableDidReachRegionAroundTheEnd() {
        add tests for it
        #warning("validate if it is not already loading or retry is not already appearing")
        if !dataStore.isLoading {
            dataStore.isLoading = true
            dataStore.view?.showLoadingCell()
        }
    }

    private func setupInitialState() {
        dataStore.view?.setSceneTitle("marvel_heroes".localized())
        dataStore.view?.hideRetryOption()
        dataStore.view?.hideCharactersTable()
        dataStore.view?.showSceneSpinner()
        dataStore.view?.hideEmptyFeedback()
    }
}

private extension HeroCellModel {
    init(hero: Hero) {
        self.init(name: hero.name)
    }
}
