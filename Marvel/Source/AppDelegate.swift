import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // **IMPORTANT**
        //
        // This flag avoid increasing the code coverage without have tests written.
        // To me it is a good approach to not fall in the false coverage metrics.

        let isTestingMode = CommandLine.arguments.contains("testingMode")

        window = Bootstrap().getWindow(for: application, isTestingMode: isTestingMode)

        return true
    }

}
