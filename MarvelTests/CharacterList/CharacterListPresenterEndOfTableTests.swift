import XCTest
@testable import Marvel

final class CharacterListPresenterEndOfTableTests: CharacterListPresenterBaseTestCase {

    func testWhenLastCellIsHidden() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .hidden

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.showLoadingCellCalled, true)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
    }

    func testWhenLastCellIsLoading() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .loading

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.showLoadingCellCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
    }

    func testWhenLastCellIsRetry() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .retry

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.showLoadingCellCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
    }

}
