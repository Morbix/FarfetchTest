import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = scene as? UIWindowScene else { return }

        let navigationController = UINavigationController(
            rootViewController: CharacterListViewController(
                presenter: CharacterListPresenter(
                    dataStore: CharacterListDataStore(),
                    fetcher: self
                )
            )
        )

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

extension SceneDelegate: CharacterListFetcher {
    func getCharacters(_ completion: @escaping (ResultHeroes) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let error = NSError(domain: .init(), code: .init(), userInfo: nil)
            //completion(.failure(error))
            completion(.success([]))
        }
    }
}
