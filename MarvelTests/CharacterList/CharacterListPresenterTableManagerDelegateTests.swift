import XCTest
@testable import Marvel

final class CharacterListPresenterTableManagerDelegateTests: CharacterListPresenterBaseTestCase {

    func testWhenLastCellStateIsNone() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .none

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
    }

    func testWhenLastCellStateIsLoading() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .loading

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
    }

    func testWhenLastCellStateIsRetry() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .retry

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
    }

}
