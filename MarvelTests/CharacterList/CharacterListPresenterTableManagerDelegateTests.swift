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

    func testAskForMoreCharacters() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .none
        dataStoreSpy.characters = .fixtureRamdomList

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
        XCTAssertEqual(fetcherSpy.skipPassed, dataStoreSpy.characters.count)
    }

}

private extension Array where Element == Hero {
    static var fixtureRamdomList: [Hero] {
        var times = (0..<3).randomElement() ?? 0
        var heroes = [Hero]()
        while times > 0 {
            heroes.append(Hero())
            times -= 1
        }
        return heroes
    }
}
