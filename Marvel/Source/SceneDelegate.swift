import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // **IMPORTANT**
        // To avoid increase the code coverage without have tests written
        let isTestingMode = CommandLine.arguments.contains("testingMode")

        window = Bootstrap().getWindow(for: scene, isTestingMode: isTestingMode)
    }
}

#warning("implement retry cell on main list")
#warning("implement star hero on main scene")
#warning("implement star hero on detail scene")
#warning("implement custom transition")
#warning("implement search on main list")
#warning("readme")
