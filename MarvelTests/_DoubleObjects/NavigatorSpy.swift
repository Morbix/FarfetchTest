@testable import Marvel

final class NavigatorSpy: Navigator {

    private(set) var pushRouterCalled: Bool = false
    private(set) var routerPassed: Router? = nil
    private(set) var animatedPassed: Bool? = nil
    func pushRouter(_ router: Router, animated: Bool) {
        pushRouterCalled = true
        routerPassed = router
        animatedPassed = animated
    }
}
