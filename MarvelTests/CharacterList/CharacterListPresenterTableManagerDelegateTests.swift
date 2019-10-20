import XCTest
@testable import Marvel

final class CharacterListPresenterTableManagerDelegateTests: CharacterListPresenterBaseTestCase {

    // MARK: tableDidReachRegionAroundTheEnd

    func testWhenLastCellStateIsLoading() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .loading
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.totalAvailable = 100

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .loading)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testWhenLastCellStateIsRetry() {
        dataStoreSpy.view = viewingSpy
        dataStoreSpy.lastCellState = .retry
        dataStoreSpy.characters = .fixtureRamdomList
        dataStoreSpy.totalAvailable = 100

        sut.tableDidReachRegionAroundTheEnd()

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
        XCTAssertEqual(fetcherSpy.getCharactersCalled, false)
    }

    func testWhenCurrentCountIsNotLessThanAvailable() {
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

    func testAskForMoreCharacters() {
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

    func testNavigateToDetailScene() {
        let hero = Hero(id: 999)
        dataStoreSpy.characters = [hero]

        sut.tableDidSelect(at: 0)

        XCTAssertEqual(routerSpy.navigateToDetailCalled, true)
        XCTAssertEqual(routerSpy.heroPassed, hero)
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
