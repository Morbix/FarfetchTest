import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // **IMPORTANT**
        // To avoid increase the code coverage without have tests written
        guard !CommandLine.arguments.contains("testingMode") else { return }

        guard let scene = scene as? UIWindowScene else { return }

//        let dataStore = CharacterListDataStore()
//        let presenter = CharacterListPresenter(
//            dataStore: dataStore,
//            fetcher: MarvelCharactersService()
//        )
//        let tableManager = CharacterListTableManager(
//            store: dataStore,
//            delegate: presenter
//        )
//        let navigationController = UINavigationController(
//            rootViewController: CharacterListViewController(
//                presenter: presenter,
//                tableManager: tableManager
//            )
//        )

        #warning("3 implement router")

        #warning("implement image on main list")
        #warning("implement star hero on main scene")
        #warning("implement star hero on detail scene")
        #warning("implement custom transition")
        #warning("implement search on main list")
        #warning("implement retry cell on main list")
        #warning("readme")

        let dataStore = CharacterDetailDataStore(hero: Hero(
            id: 1011334,
            name: "Dummy",
            comics: [Content(name: "comic 1", description: nil)],
            series: [Content(name: "serie 1", description: nil)],
            stories: [],
            events: [
                Content(name: "event 1", description: nil),
                Content(name: "event 1", description: nil),
                Content(name: "event 1", description: nil),
                Content(name: "event 1", description: nil),
                Content(name: "event 1", description: nil),
                Content(name: "event 1", description: nil)
            ]
        ))
        let presenter = CharacterDetailPresenter(
            dataStore: dataStore,
            fetcher: MarvelCharactersService()
        )
        let tableManager = CharacterDetailTableManager(
            tableStore: presenter
        )
        let navigationController = UINavigationController(
            rootViewController: CharacterDetailViewController(
                presenter: presenter,
                tableManager: tableManager
            )
        )

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
