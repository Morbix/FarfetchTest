import UIKit

protocol Router {
    func makeViewController() -> UIViewController
}

protocol Navigator: class {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func presentViewController(_ viewController: UIViewController,
                               transitionDelegate transition: UIViewControllerTransitioningDelegate)
}

extension UINavigationController: Navigator {
    func presentViewController(_ viewControllerToShow: UIViewController,
                               transitionDelegate transition: UIViewControllerTransitioningDelegate) {
        viewControllerToShow.transitioningDelegate = transition
        viewControllerToShow.modalPresentationStyle = .custom

        present(viewControllerToShow, animated: true)
    }
}
