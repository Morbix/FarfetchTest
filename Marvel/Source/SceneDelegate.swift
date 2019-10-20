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

        #warning("implement image on main list")
        #warning("implement star hero on main scene")
        #warning("implement star hero on detail scene")
        #warning("implement custom transition")
        #warning("implement search on main list")
        #warning("implement retry cell on main list")
        #warning("readme")

        let navigationController = UINavigationController()
        navigationController.pushRouter(CharacterListRouter(navigator: navigationController))

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
