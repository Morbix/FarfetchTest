import XCTest
@testable import Marvel

final class NavigationTests: XCTestCase {

    func testSceneMixin() {
        let mock = UIViewControllerMock()
        let sut: Scene = mock

        let viewController = sut.makeViewController()

        XCTAssertTrue(viewController === mock)
    }


    func testUINavigationControllerPushRouter() {
        let viewController = UIViewControllerMock()
        let routerStub = RouterStub(scene: viewController)
        let navigationController = UINavigationController()

        navigationController.pushRouter(routerStub, animated: false)

        XCTAssertTrue(navigationController.viewControllers.first === viewController)
    }
}

private class UIViewControllerMock: UIViewController, Scene {}

private class RouterStub: Router {

    private let scene: Scene
    init(scene: Scene) {
        self.scene = scene
    }

    func makeScene() -> Scene {
        return scene
    }
}
