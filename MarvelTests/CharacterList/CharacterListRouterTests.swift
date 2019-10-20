import XCTest
@testable import Marvel

final class CharacterListRouterTests: XCTestCase {

    private let navigatorSpy = NavigatorSpy()
    private lazy var sut = CharacterListRouter(
        navigator: navigatorSpy
    )

    func testMakeScene() throws {
        let scene = sut.makeScene()

        XCTAssertTrue(scene is CharacterListViewController)

        let sceneMirror = Mirror(reflecting: scene)
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
        let hero = Hero(id: 999)

        sut.navigateToDetail(hero: hero)

        XCTAssertEqual(navigatorSpy.pushRouterCalled, true)
        XCTAssertEqual(navigatorSpy.routerPassed is CharacterDetailRouter, true)

        let routerMirror = Mirror(reflecting: try XCTUnwrap(navigatorSpy.routerPassed))
        let navigatorProperty = try XCTUnwrap(routerMirror.firstChild(of: Navigator.self))
        XCTAssertEqual(navigatorProperty === navigatorSpy, true)
        let heroProperty = try XCTUnwrap(routerMirror.firstChild(of: Hero.self))
        XCTAssertEqual(heroProperty === hero, true)
    }
}
