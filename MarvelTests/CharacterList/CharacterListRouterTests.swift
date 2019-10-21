import XCTest
@testable import Marvel

final class CharacterListRouterTests: XCTestCase {

    private let navigatorSpy = NavigatorSpy()
    private lazy var sut = CharacterListRouter(
        navigator: navigatorSpy
    )

    func testMakeViewController() throws {
        let viewController = sut.makeViewController()

        XCTAssertTrue(viewController is CharacterListViewController)

        let sceneMirror = Mirror(reflecting: viewController)
        let presenterProperty = try XCTUnwrap(sceneMirror.firstChild(of: CharacterListPresenter.self))
        let tableManagerProperty = try XCTUnwrap(sceneMirror.firstChild(of: CharacterListTableManager.self))

        let tableManagerMirror = Mirror(reflecting: tableManagerProperty)
        let storeProperty = try XCTUnwrap(tableManagerMirror.firstChild(of: CharacterListTableStore.self))
        let delegateProperty = try XCTUnwrap(tableManagerMirror.firstChild(of: CharacterListTableManagerDelegate.self))
        XCTAssertEqual(storeProperty === presenterProperty, true)
        XCTAssertEqual(delegateProperty === presenterProperty, true)

        let presenterMirror = Mirror(reflecting: presenterProperty)
        XCTAssertNotNil(presenterMirror.firstChild(of: MarvelCharactersService.self))
        XCTAssertNotNil(presenterMirror.firstChild(of: CharacterListDataStore.self))

        let routerProperty = try XCTUnwrap(presenterMirror.firstChild(of: CharacterListRoutering.self))
        XCTAssertEqual(routerProperty as? CharacterListRouter  === sut, true)
    }

    func testNavigateToDetail() throws {
        sut.navigateToDetail(hero: Hero())

        XCTAssertEqual(navigatorSpy.presentViewControllerCalled, true)

        let navigationController = try XCTUnwrap(navigatorSpy.viewControllerPassed as? UINavigationController)
        XCTAssertNotNil(navigationController.viewControllers.first as? CharacterDetailViewController)
    }
}
