import XCTest
@testable import Marvel

class CharacterListTableManagerBaseTestCase: XCTestCase {

    let tableSpy = UITableViewMock()
    let sut = CharacterListTableManager()

    func testStartWithEmptyHeroes() {
        XCTAssertEqual(sut.heroes.isEmpty, true)
    }

    func testAttachShouldSetProtocols() {
        XCTAssertNil(tableSpy.dataSource)
        XCTAssertNil(tableSpy.delegate)

        sut.attach(on: tableSpy)

        XCTAssertTrue(tableSpy.dataSource === sut)
        XCTAssertTrue(tableSpy.delegate === sut)
    }

    func testAttachShouldRegisterCells() {
        sut.attach(on: tableSpy)

        XCTAssertEqual(tableSpy.registerCalled, true)
        XCTAssertEqual(tableSpy.cellClasses.containsClass(UITableViewCell.self), true)
        XCTAssertEqual(tableSpy.identifiers.contains("Cell"), true)
    }

    
}

// MARK: - HeroCellModel Fixtures

extension HeroCellModel {
    static var fixtureRamdomList: [HeroCellModel] {
        let number = (0..<3).randomElement() ?? 0
        return fixtureList.dropLast(number)
    }

    static var fixtureList: [HeroCellModel] {
        return (0..<3).map(HeroCellModel.init)
    }
}

private extension HeroCellModel {
    init(_ index: Int) {
        self.init(name: "Hero \(index)")
    }
}
