import XCTest
@testable import Marvel

final class CharacterDetailRouterTests: XCTestCase {

    private let navigatorSpy = NavigatorSpy()
    private let hero = Hero(id: 999)
    private lazy var sut = CharacterDetailRouter(
        navigator: navigatorSpy,
        hero: hero
    )

    func testMakeScene() throws {
        let scene = sut.makeScene()

        XCTAssertTrue(scene is CharacterDetailViewController)

        let sceneMirror = Mirror(reflecting: scene)
        let presenterProperty = try XCTUnwrap(sceneMirror.firstChild(of: CharacterDetailPresenter.self))
        let tableManagerProperty = try XCTUnwrap(sceneMirror.firstChild(of: CharacterDetailTableManager.self))

        let tableManagerMirror = Mirror(reflecting: tableManagerProperty)
        let tableStoreProperty = try XCTUnwrap(tableManagerMirror.firstChild(of: CharacterDetailTableStore.self))
        XCTAssertEqual(tableStoreProperty === presenterProperty, true)

        let presenterMirror = Mirror(reflecting: presenterProperty)
        XCTAssertNotNil(presenterMirror.firstChild(of: MarvelCharactersService.self))
        let dataStoreProperty = try XCTUnwrap(presenterMirror.firstChild(of: CharacterDetailDataStore.self))
        XCTAssertEqual(dataStoreProperty.hero, hero)
    }
}
