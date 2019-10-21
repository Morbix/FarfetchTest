import XCTest
@testable import Marvel

final class CharacterListPresenterTableManagerDelegateTests: CharacterListPresenterBaseTestCase {

    // MARK: tableDidReachRegionAroundTheEnd

    func testDidReachTheEndWhenLastCellStateIsLoading() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .loading
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.totalAvailable = 100

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidReachTheEndWhenLastCellStateIsRetry() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .retry
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.totalAvailable = 100

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidReachTheEndWhenLastCellStateIsNoneAndCurrentCountIsNotLessThanAvailable() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .none
        dataStoreSpy.totalAvailable = 2
        dataStoreSpy.characters.append(.init())
        dataStoreSpy.characters.append(.init())


        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .none)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidReachTheEndWhenLastCellStateIsNoneAndCurrentCountIsLessThanAvailable() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .none
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.totalAvailable = 100

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
        XCTAssertEqual(fetcherSpy.skipPassed, dataStoreSpy.characters.count)
        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
    }

    // MARK: tableDidSelectAt

    func testDidSelectAtForIndexLessThanZero() {
        let hero = Hero(id: 999)
        dataStoreSpy.characters = [hero]

        sut.tableDidSelect(at: -1)

        XCTAssertEqual(routerSpy.navigateToDetailCalled, false)
    }

    func testDidSelectAtForIndexOutOfBounds() {
        dataStoreSpy.characters = []

        sut.tableDidSelect(at: 1)

        XCTAssertEqual(routerSpy.navigateToDetailCalled, false)
    }

    func testDidSelectWhenIndexCorrespondToHero() {
        let hero = Hero(id: 999)
        dataStoreSpy.characters = [hero]

        sut.tableDidSelect(at: 0)

        XCTAssertEqual(routerSpy.navigateToDetailCalled, true)
        XCTAssertEqual(routerSpy.heroPassed, hero)
    }

    // MARK: tableDidRetry

    func testDidRetryWhenLastCellStateIsNone() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .none

        sut.tableDidRetry()

        XCTAssertEqual(dataStoreSpy.lastCellState, .none)
        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidRetryWhenLastCellStateIsLoading() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .loading

        sut.tableDidRetry()

        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidRetryWhenLastCellStateIsRetryButCurrentCountIsNotLessThanAvailable() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .retry
        dataStoreSpy.totalAvailable = 2
        dataStoreSpy.characters.append(.init())
        dataStoreSpy.characters.append(.init())


        sut.tableDidRetry()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testDidRetryWhenLastCellStateIsRetryAndCurrentCountIsLessThanAvailable() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.lastCellState = .retry
        dataStoreSpy.totalAvailable = 100

        sut.tableDidRetry()

        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
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
