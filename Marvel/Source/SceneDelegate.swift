import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // **IMPORTANT**
        //
        // This flag avoid increasing the code coverage without have tests written.
        // To me it is a good approach to not fall in the false coverage metrics.

        let isTestingMode = CommandLine.arguments.contains("testingMode")

        window = Bootstrap().getWindow(for: scene, isTestingMode: isTestingMode)
    }
}
