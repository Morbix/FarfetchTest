import Foundation

final class CharacterListRouter: Router, CharacterListRoutering {

    private unowned let navigator: Navigator

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func makeScene() -> Scene {
        let presenter = CharacterListPresenter(
            dataStore: CharacterListDataStore(),
            fetcher: MarvelCharactersService(),
            router: self
        )
        let tableManager = CharacterListTableManager(
            store: presenter,
            delegate: presenter
        )
        return CharacterListViewController(
            presenter: presenter,
            tableManager: tableManager
        )
    }

    func navigateToDetail(hero: Hero) {
        let router = CharacterDetailRouter(navigator: navigator, hero: hero)
        navigator.pushRouter(router, animated: true)
    }

}
