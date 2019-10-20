import UIKit

protocol Scene {
    func makeViewController() -> UIViewController
}

extension Scene where Self: UIViewController {
    #warning("test this")
    func makeViewController() -> UIViewController {
        return self
    }
}

protocol Router {
    func makeScene() -> Scene
}

protocol Navigator: class {
    func pushRouter(_ router: Router, animated: Bool)
}

extension UINavigationController: Navigator {
    #warning("test this")
    func pushRouter(_ router: Router, animated: Bool = true) {
        pushViewController(router.makeScene().makeViewController(), animated: animated)
    }
}
