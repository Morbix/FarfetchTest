import XCTest
@testable import Marvel

final class CharacterListTableStoreTests: XCTestCase {

    private let dataStore = CharacterListDataStore()
    private lazy var sut = CharacterListPresenter(
        dataStore: dataStore,
        fetcher: CharacterListFetcherSpy(),
        router: CharacterListRouteringSpy()
    )

    func testLastCellState() throws {
        let state = [State.none, State.retry, State.loading].randomElement()
        dataStore.lastCellState = try XCTUnwrap(state)

        XCTAssertEqual(sut.lastCellState, state)
    }

    func testHeroesFor1Character() {
        dataStore.characters = [
            .init(id: 1)
        ]


        let item1 = sut.heroes.first
        XCTAssertEqual(item1?.name, "item 1")
    }

    func testHeroesFor3Characteres() {
        dataStore.characters = [
            .init(id: 1),
            .init(id: 2),
            .init(id: 3)
        ]


        let item1 = sut.heroes[safe: 0]
        XCTAssertEqual(item1?.name, "item 1")

        let item2 = sut.heroes[safe: 1]
        XCTAssertEqual(item2?.name, "item 2")

        let item3 = sut.heroes[safe: 2]
        XCTAssertEqual(item3?.name, "item 3")

        XCTAssertEqual(sut.heroes.count, 3)
    }
}

// MARK: - Hero Dummy
extension Hero {
    convenience init(id: Int) {
        self.init(
            id: id,
            name: "item \(id)",
            comics: [],
            series: [],
            stories: [],
            events: []
        )
    }
}
