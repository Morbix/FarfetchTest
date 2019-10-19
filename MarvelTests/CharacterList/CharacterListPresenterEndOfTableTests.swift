import XCTest
@testable import Marvel

final class CharacterListPresenterEndOfTableTests: CharacterListPresenterBaseTestCase {

    func testShowLoadingCell() {
        dataStoreSpy.view = viewingSpy

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.showLoadingCellCalled, true)
    }

}
