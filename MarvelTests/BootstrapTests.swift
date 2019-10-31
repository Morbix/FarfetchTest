import XCTest
@testable import Marvel

final class BootstrapTests: XCTestCase {

    private let factoryMock = FirstRouterFactoryMock()
    private lazy var sut = Bootstrap(factory: factoryMock)

    func testInTestMode() throws {
        let window = sut.getWindow(for: UIApplication.shared, isTestingMode: true)
        XCTAssertNil(window)
    }

    func testRootViewController() throws {
        let window = sut.getWindow(for: UIApplication.shared, isTestingMode: false)

        XCTAssertNotNil(window)
        let navController = try XCTUnwrap(window?.rootViewController as? UINavigationController)
        XCTAssertTrue(navController.viewControllers.first is UIViewControllerMock, "is not UIViewControllerMock")
    }
}
