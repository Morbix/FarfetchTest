import XCTest
@testable import Marvel

final class CharacterListTableManagerDataSourceTests: CharacterListTableManagerBaseTestCase {

    // MARK: numberOf's

    func testNumberOfSection() {
        let result = sut.numberOfSections(in: tableSpy)

        XCTAssertEqual(result, 1)
    }

    func testNumberOfRowsInFirstSection() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 0)

        XCTAssertEqual(result, viewModels.count)
    }

    // MARK: cellForRowAt's

    func testDequeueReusableCell() {
        let _ = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 0, section: 0)
        )

        XCTAssertEqual(tableSpy.identifierPassed, "Cell")
        XCTAssertEqual(tableSpy.indexPathPassed?.row, 0)
        XCTAssertEqual(tableSpy.indexPathPassed?.section, 0)

        let _ = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 1, section: 1)
        )

        XCTAssertEqual(tableSpy.identifierPassed, "Cell")
        XCTAssertEqual(tableSpy.indexPathPassed?.row, 1)
        XCTAssertEqual(tableSpy.indexPathPassed?.section, 1)

        let _ = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 0, section: 1)
        )

        XCTAssertEqual(tableSpy.identifierPassed, "Cell")
        XCTAssertEqual(tableSpy.indexPathPassed?.row, 0)
        XCTAssertEqual(tableSpy.indexPathPassed?.section, 1)

        let _ = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 1, section: 0)
        )

        XCTAssertEqual(tableSpy.identifierPassed, "Cell")
        XCTAssertEqual(tableSpy.indexPathPassed?.row, 1)
        XCTAssertEqual(tableSpy.indexPathPassed?.section, 0)
    }

    func testCellForRowInFirstSection() {
        let viewModels = HeroCellModel.fixtureList
        sut.heroes.append(contentsOf: viewModels)

        let cell1 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 0, section: 0)
        )
        XCTAssertEqual(cell1.reuseIdentifier, "Cell")
        XCTAssertEqual(cell1.textLabel?.text, "Hero 0")

        let cell2 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 1, section: 0)
        )
        XCTAssertEqual(cell2.reuseIdentifier, "Cell")
        XCTAssertEqual(cell2.textLabel?.text, "Hero 1")

        let cell3 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 2, section: 0)
        )
        XCTAssertEqual(cell3.reuseIdentifier, "Cell")
        XCTAssertEqual(cell3.textLabel?.text, "Hero 2")

        let cell4 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 3, section: 0)
        )
        XCTAssertNil(cell4.textLabel?.text)
    }

}
