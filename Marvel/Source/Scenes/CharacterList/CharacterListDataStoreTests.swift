import XCTest
@testable import Marvel

final class CharacterListDataStoreTests: XCTestCase {

    private let sut = CharacterListDataStore()

    func testCharactersStartsEmpty() {
        XCTAssertEqual(sut.characters.isEmpty, true)
    }

    func testLastCellStateStartsHidden() {
        XCTAssertEqual(sut.lastCellState, .hidden)
    }

    func testViewStartsNil() {
        XCTAssertNil(sut.view)
    }
}
