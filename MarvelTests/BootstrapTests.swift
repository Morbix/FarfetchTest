import XCTest
@testable import Marvel

final class BootstrapTests: XCTestCase {

    private let factoryMock = FirstRouterFactoryMock()
    private let currentScene = UIApplication.shared.connectedScenes.first
    private lazy var sut = Bootstrap(factory: factoryMock)

    func testInTestMode() throws {
        let scene = try XCTUnwrap(currentScene)
        let window = sut.getWindow(for: scene, isTestingMode: true)
        XCTAssertNil(window)
    }

    func testRootViewController() throws {
        let scene = try XCTUnwrap(currentScene)
        let window = sut.getWindow(for: scene, isTestingMode: false)

        XCTAssertNotNil(window)
        let navController = try XCTUnwrap(window?.rootViewController as? UINavigationController)
        XCTAssertTrue(navController.viewControllers.first is UIViewControllerMock, "is not UIViewControllerMock")
    }
}
