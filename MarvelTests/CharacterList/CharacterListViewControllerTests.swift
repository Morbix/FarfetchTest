import XCTest
@testable import Marvel

final class CharacterListViewControllerTests: XCTestCase {

    func testSetTableManagerDelegate() {
        let presenter = CharacterListPresenter(
            dataStore: .init(),
            fetcher: CharacterListFetcherSpy()
        )
        let sut = CharacterListViewController(
            presenter: presenter
        )
        let mirror = Mirror(reflecting: sut)
        let tableManagerProperty = mirror.firstChild(of: CharacterListTableManager.self)

        XCTAssertNotNil(tableManagerProperty)
        XCTAssertNotNil(tableManagerProperty?.delegate)
        XCTAssertTrue(tableManagerProperty?.delegate === sut)
    }

}
