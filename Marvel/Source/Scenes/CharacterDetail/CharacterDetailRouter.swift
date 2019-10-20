import Foundation

final class CharacterDetailRouter: Router {

    private weak var navigator: Navigator?
    private let hero: Hero

    init(navigator: Navigator, hero: Hero) {
        self.navigator = navigator
        self.hero = hero
    }

    func makeScene() -> Scene {
        let presenter = CharacterDetailPresenter(
            dataStore: CharacterDetailDataStore(hero: hero),
            fetcher: MarvelCharactersService()
        )
        let tableManager = CharacterDetailTableManager(
            tableStore: presenter
        )
        return CharacterDetailViewController(
            presenter: presenter,
            tableManager: tableManager
        )
    }
}
