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
    func includeCharacters(_ characters: [HeroeCellModel])
    func setSceneTitle(_ title: String)
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
                view.hideRetryCell()
                view.hideRetryOption()

                if items.isEmpty && dataStore.characters.isEmpty {
                    view.showEmptyFeeback()
                    view.hideCharactersTable()
                } else {
                    view.showCharacteresTable()
                    dataStore.characters.append(contentsOf: items)
                    view.includeCharacters(items.map(HeroeCellModel.init))
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

    private func setupInitialState() {
        dataStore.view?.setSceneTitle("marvel_heroes".localized())
        dataStore.view?.hideRetryOption()
        dataStore.view?.hideCharactersTable()
        dataStore.view?.showSceneSpinner()
    }
}

private extension HeroeCellModel {
    init(heroe: Heroe) {
        self.init(name: heroe.name)
    }
}
