import XCTest
@testable import Marvel

final class CharacterListTableManagerDelegateTests: CharacterListTableManagerBaseTestCase {

    func testDidSelectRowAtRetryCell() {
        tableStoreSpy.lastCellState = .retry
        let indexPath = IndexPath(row: 0, section: 1)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, true)
    }

    func testDidSelectRowAtLoadingCell() {
        tableStoreSpy.lastCellState = .loading
        let indexPath = IndexPath(row: 0, section: 1)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, false)
    }

    func testDidSelectRowAtForRowOutOfBounds() {
        tableStoreSpy.heroes = [.init(name: "")]
        let indexPath = IndexPath(row: 1, section: 0)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, false)
    }

    func testDidSelectRowAtForSectionOutOfBounds1() {
        tableStoreSpy.heroes = [.init(name: "")]
        tableStoreSpy.lastCellState = .none
        let indexPath = IndexPath(row: 0, section: 1)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, false)
    }

    func testDidSelectRowAtForSectionOutOfBounds2() {
        tableStoreSpy.heroes = [.init(name: "")]
        tableStoreSpy.lastCellState = .retry
        let indexPath = IndexPath(row: 0, section: 2)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, true)
    }

    func testDidSelectRowAtHeroWithoutDetails() {
        tableStoreSpy.heroes = [.init(name: "", hasDetail: false)]
        let indexPath = IndexPath(row: 0, section: 0)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, false)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, false)
    }

    func testDidSelectRowAtHeroWithDetails() {
        tableStoreSpy.heroes = [.init(name: "", hasDetail: true)]
        let indexPath = IndexPath(row: 0, section: 0)

        sut.tableView(tableSpy, didSelectRowAt: indexPath)

        XCTAssertEqual(delegateSpy.tableDidSelectCalled, true)
        XCTAssertEqual(delegateSpy.tableDidRetryCalled, false)
    }
}
