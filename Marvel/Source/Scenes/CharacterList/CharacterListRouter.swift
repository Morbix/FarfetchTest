import UIKit

final class CharacterListRouter: Router, CharacterListRoutering {

    private unowned let navigator: Navigator
    private let transition: CircularTransition = .init()

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func makeViewController() -> UIViewController {
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
        let router = CharacterDetailRouter(hero: hero)
        let navigationController = UINavigationController(
            rootViewController: router.makeViewController()
        )

        navigator.presentViewController(navigationController, transitionDelegate: transition)
    }

}
