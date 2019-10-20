import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // To avoid increase the code coverage without have tests written
        guard !CommandLine.arguments.contains("testingMode") else { return }

        guard let scene = scene as? UIWindowScene else { return }

        let dataStore = CharacterListDataStore()
        let presenter = CharacterListPresenter(
            dataStore: dataStore,
            fetcher: MarvelCharactersService()
        )
        let tableManager = CharacterListTableManager(
            store: dataStore,
            delegate: presenter
        )
        let navigationController = UINavigationController(
            rootViewController: CharacterListViewController(
                presenter: presenter,
                tableManager: tableManager
            )
        )

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
