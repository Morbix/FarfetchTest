import UIKit
@testable import Marvel

final class NavigatorSpy: Navigator {

    private(set) var pushViewControllerCalled: Bool = false
    private(set) var viewControllerPassed: UIViewController? = nil
    private(set) var animatedPassed: Bool? = nil
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        viewControllerPassed = viewController
        animatedPassed = animated
    }

    private(set) var presentViewControllerCalled: Bool = false
    private(set) var transitionPassed: UIViewControllerTransitioningDelegate? = nil
    func presentViewController(_ viewController: UIViewController, transitionDelegate transition: UIViewControllerTransitioningDelegate) {
        presentViewControllerCalled = true
        viewControllerPassed = viewController
        transitionPassed = transition
    }
}
