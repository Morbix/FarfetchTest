import XCTest
@testable import Marvel

class CharacterListPresenterBaseTestCase: XCTestCase {

    let fetcherSpy = CharacterListFetcherSpy()
    let dataStoreSpy = CharacterListDataStore()
    let viewingSpy = CharacterListViewingSpy()
    let routerSpy = CharacterListRouteringSpy()
    
    lazy var sut = CharacterListPresenter(
        dataStore: dataStoreSpy,
        fetcher: fetcherSpy,
        router: routerSpy
    )

    func testDataStorePassed() {
        let mirror = Mirror(reflecting: sut)
        let dataStoreProperty = mirror.firstChild(of: CharacterListDataStore.self)
        XCTAssertNotNil(dataStoreProperty)
        XCTAssertTrue(dataStoreProperty === dataStoreSpy)
    }

    func testFetcherPassed() {
        let mirror = Mirror(reflecting: sut)
        let fetcherProperty = mirror.firstChild(of: CharacterListFetcher.self)
        XCTAssertNotNil(fetcherProperty)
        XCTAssertTrue(fetcherProperty === fetcherSpy)
    }
}
