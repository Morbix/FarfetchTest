import XCTest
@testable import Marvel

final class CharacterListDataStoreTests: XCTestCase {

    private let sut = CharacterListDataStore()

    func testCharactersStartsEmpty() {
        XCTAssertEqual(sut.characters.isEmpty, true)
    }

    func testLastCellStateStartsHidden() {
        XCTAssertEqual(sut.lastCellState, .none)
    }

    func testViewStartsNil() {
        XCTAssertNil(sut.view)
    }

    // MARK: CharacterListTableStore

    func testHeroesFor1Character() {
        sut.characters = [
            .init(name: "item 1")
        ]


        let item1 = sut.heroes.first
        XCTAssertEqual(item1?.name, "item 1")
    }

    func testHeroesFor3Characteres() {
        sut.characters = [
            .init(name: "item 1"),
            .init(name: "item 2"),
            .init(name: "item 3")
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

