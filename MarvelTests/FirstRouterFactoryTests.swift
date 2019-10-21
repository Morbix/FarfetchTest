import XCTest
@testable import Marvel

final class FirstRouterFactoryTests: XCTestCase {

    private let navigatorSpy = NavigatorSpy()
    private let sut = FirstRouterFactory()

    func testCreateRouter() throws {
        let router = sut.createRouter(with: navigatorSpy)

        XCTAssertTrue(router is CharacterListRouter, "is not CharacterListRouter")

        let mirror = Mirror(reflecting: router)
        let navigatorProperty = mirror.firstChild(of: Navigator.self)
        XCTAssertEqual(navigatorProperty === navigatorSpy, true)
    }
}
