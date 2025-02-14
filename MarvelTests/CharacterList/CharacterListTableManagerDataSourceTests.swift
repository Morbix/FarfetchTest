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
        tableStoreSpy.heroes.append(contentsOf: viewModels)

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 0)

        XCTAssertEqual(result, viewModels.count)
    }

    func testNumberOfRowsInSecondSectionWithStateHidden() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .none

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(result, 0)
    }

    func testNumberOfRowsInSecondSectionWithStateLoading() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .loading

        let result = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(result, 1)
    }

    func testNumberOfRowsInSecondSectionWithStateRetry() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .retry

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
        XCTAssertEqual(tableSpy.identifierPassed, "cell")
    }

    // MARK: cellForRowAt for First Section

    func testCellForRowInFirstSection() {
        let viewModels = HeroCellModel.fixtureList
        tableStoreSpy.heroes.append(contentsOf: viewModels)

        let cell1 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 0, section: 0)
        )
        XCTAssertEqual(cell1.textLabel?.text, "Hero 0")
        XCTAssertEqual(cell1.textLabel?.textColor, .black)

        let cell2 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 1, section: 0)
        )
        XCTAssertEqual(cell2.textLabel?.text, "Hero 1")
        XCTAssertEqual(cell2.textLabel?.textColor, .black)

        let cell3 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 2, section: 0)
        )
        XCTAssertEqual(cell3.textLabel?.text, "Hero 2")
        XCTAssertEqual(cell3.textLabel?.textColor, .black)

        let cell4 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 3, section: 0)
        )
        XCTAssertNil(cell4.textLabel?.text)
    }

    func testCellForRowForFirstSectionAccessoryTypeAndSelectionStyle() {
        tableStoreSpy.heroes = [
            .init(name: "", hasDetail: true),
            .init(name: "", hasDetail: false),
        ]

        let cell1 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 0, section: 0)
        )
        XCTAssertEqual(cell1.accessoryType, .disclosureIndicator)
        XCTAssertEqual(cell1.selectionStyle, .gray)

        let cell2 = sut.tableView(tableSpy, cellForRowAt: IndexPath(
            row: 1, section: 0)
        )
        XCTAssertEqual(cell2.accessoryType, .none)
        XCTAssertEqual(cell2.selectionStyle, .none)
    }

    // MARK: cellForRowAt for Second Section

    func testCellForRowForSecondSectionSelectionStyle() {
        tableStoreSpy.lastCellState = .retry

        let cell1 = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell1.selectionStyle, .gray)

        tableStoreSpy.lastCellState = .loading

        let cell2 = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell2.selectionStyle, .none)
    }

    func testCellForRowAtInSecondSectionWithStateHidden() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .none

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertNil(cell.textLabel?.text)
    }

    func testCellForRowAtInSecondSectionWithStateLoading() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .loading

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell.textLabel?.text, "Loading...")
        XCTAssertEqual(cell.textLabel?.textColor, .lightGray)
        XCTAssertEqual(cell.accessoryType, .none)
    }

    func testCellForRowAtInSecondSectionWithStateRetry() {
        let viewModels = HeroCellModel.fixtureRamdomList
        tableStoreSpy.heroes.append(contentsOf: viewModels)
        tableStoreSpy.lastCellState = .retry

        let cell = sut.tableView(tableSpy, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell.textLabel?.text, "Touch here to try again!")
        XCTAssertEqual(cell.textLabel?.textColor, .lightGray)
        XCTAssertEqual(cell.accessoryType, .none)
    }

}
