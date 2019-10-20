import XCTest
@testable import Marvel

class CharacterDetailPresenterBaseTestCase: XCTestCase {

    let fetcherSpy = CharacterDetailFetcherSpy()
    let viewingSpy = CharacterDetailViewingSpy()
    lazy var dataStoreSpy = CharacterDetailDataStore(
        hero: Hero(id: 999)
    )
    lazy var sut = CharacterDetailPresenter(
        dataStore: dataStoreSpy,
        fetcher: fetcherSpy
    )

    func testDataStorePassed() {
        let mirror = Mirror(reflecting: sut)
        let dataStoreProperty = mirror.firstChild(of: CharacterDetailDataStore.self)
        XCTAssertNotNil(dataStoreProperty)
        XCTAssertTrue(dataStoreProperty === dataStoreSpy)
    }

    func testFetcherPassed() {
        let mirror = Mirror(reflecting: sut)
        let fetcherProperty = mirror.firstChild(of: CharacterDetailFetcherSpy.self)
        XCTAssertNotNil(fetcherProperty)
        XCTAssertTrue(fetcherProperty === fetcherSpy)
    }
}
