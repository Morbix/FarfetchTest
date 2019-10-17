import XCTest
@testable import Marvel

final class CharacterListPresenterInitTests: CharacterListPresenterBaseTestCase {

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
