import XCTest
@testable import Marvel

final class CharacterListTableManagerDataSourceTests: CharacterListTableManagerBaseTestCase {

    // MARK: numberOf's

    func testNumberOfSection() {
        let result = sut.numberOfSections(in: tableSpy)

        XCTAssertEqual(result, 2)
    }

    func testNumberOfRowsInFirstSection() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 0)

        XCTAssertEqual(result, viewModels.count)
    }

    func testNumberOfRowsInSecondSectionWithStateHidden() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .hidden

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(result, 0)
    }

    func testNumberOfRowsInSecondSectionWithStateLoading() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .loading

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(result, 1)
    }

    func testNumberOfRowsInSecondSectionWithStateRetry() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .retry

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(result, 1)
    }

    // MARK: DequeueReusableCell

    func testDequeueReusableCell() throws {
        let expectedRow = try XCTUnwrap((0...9).randomElement())
        let expectedSection = try XCTUnwrap((0...9).randomElement())

        let _ = sut.tableView(tableSpy, cellForRowAt:
            IndexPath(row: expectedRow, section: expectedSection)
        )

        XCTAssertEqual(tableSpy.indexPathPassed?.row, expectedRow)
        XCTAssertEqual(tableSpy.indexPathPassed?.section, expectedSection)
    }

    // MARK: cellForRowAt for First Section

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

    // MARK: cellForRowAt for Second Section

    func testCellForRowAtInSecondSectionWithStateHidden() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .hidden

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertNil(cell.textLabel?.text)
    }

    func testCellForRowAtInSecondSectionWithStateLoading() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .loading

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell.textLabel?.text, "Loading...")
    }

    func testCellForRowAtInSecondSectionWithStateRetry() {
        let viewModels = HeroCellModel.fixtureRamdomList
        sut.heroes.append(contentsOf: viewModels)
        sut.lastCellState = .retry

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell.textLabel?.text, "Touch here to try again!")
    }

}
