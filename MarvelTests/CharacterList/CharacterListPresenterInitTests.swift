import XCTest
@testable import Marvel

final class CharacterListPresenterInitTests: CharacterListPresenterBaseTestCase {

    func testDataStorePassedOnContructor() {
        let mirror = Mirror(reflecting: sut)
        let dataStoreProperty = mirror.firstChild(of: CharacterListDataStore.self)
        XCTAssertNotNil(dataStoreProperty)
        XCTAssertTrue(dataStoreProperty === dataStoreSpy)
    }
    
}
