import UIKit

final class CharacterDetailRouter: Router {

    private let hero: Hero

    init(hero: Hero) {
        self.hero = hero
    }

    func makeViewController() -> UIViewController {
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
