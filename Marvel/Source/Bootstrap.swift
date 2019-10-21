import UIKit

final class Bootstrap {

    private let factory: FirstRouterFactory
    
    init(factory: FirstRouterFactory = FirstRouterFactory()) {
        self.factory = factory
    }

    func getWindow(for scene: UIScene, isTestingMode: Bool) -> UIWindow? {
        guard !isTestingMode else { return nil }

        guard let scene = scene as? UIWindowScene else { return nil }

        let navigationController = UINavigationController()
        navigationController.pushRouter(factory.createRouter(with: navigationController), animated: false)

        let window = UIWindow(windowScene: scene)
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
