import UIKit

final class Bootstrap {

    private let factory: FirstRouterFactory
    
    init(factory: FirstRouterFactory = FirstRouterFactory()) {
        self.factory = factory
    }

    func getWindow(for application: UIApplication, isTestingMode: Bool) -> UIWindow? {
        guard !isTestingMode else { return nil }

        let navigationController = UINavigationController()
        let router = factory.createRouter(with: navigationController)
        navigationController.pushViewController(router.makeViewController(), animated: false)

        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return window
    }
}

class FirstRouterFactory {
    func createRouter(with navigator: Navigator) -> Router {
        return CharacterListRouter(navigator: navigator)
    }
}
