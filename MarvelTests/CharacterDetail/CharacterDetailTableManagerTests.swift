import XCTest
@testable import Marvel

final class CharacterDetailTableManagerBaseTestCase: XCTestCase {

    private let tableSpy = UITableViewMock()
    private let tableStoreSpy = CharacterDetailTableStoreSpy()
    private lazy var sut = CharacterDetailTableManager(
        tableStore: tableStoreSpy
    )

    // MARK: Attach tableView

    func testAttachShouldSetProtocols() {
        XCTAssertNil(tableSpy.dataSource)

        sut.attach(on: tableSpy)

        XCTAssertTrue(tableSpy.dataSource === sut)
    }

    func testAttachShouldRegisterCells() {
        sut.attach(on: tableSpy)

        XCTAssertEqual(tableSpy.registerCalled, true)
        XCTAssertEqual(tableSpy.cellClasses.containsClass(UITableViewCell.self), true)
        XCTAssertEqual(tableSpy.identifiers.contains("cellWithSubtitle"), true)
        XCTAssertEqual(tableSpy.identifiers.contains("cellWithoutSubtitle"), true)
    }

    // MARK: NumberOfSections

    func testNumberOfSections() {
        tableStoreSpy.sections = .fixtureRamdomList

        let sections = sut.numberOfSections(in: tableSpy)

        XCTAssertEqual(sections, tableStoreSpy.sections.count)
    }

    // MARK: NumberOfRows

    func testNumberOfRows() {
        tableStoreSpy.sections = .fixtureRamdomList

        tableStoreSpy.sections.enumerated().forEach { (index, element) in
            let rows = sut.tableView(tableSpy, numberOfRowsInSection: index)

            XCTAssertEqual(rows, element.details.count)
        }
    }

    func testNumberOfRowsForIndexOutOfBounds() {
        tableStoreSpy.sections = []

        let rows = sut.tableView(tableSpy, numberOfRowsInSection: 1)

        XCTAssertEqual(rows, 0)
    }

    // MARK: titleForHeaderInSection

    func testTitleForHeaderForIndexOutOfBounds() {
        tableStoreSpy.sections = []

        let title = sut.tableView(tableSpy, titleForHeaderInSection: 1)

        XCTAssertNil(title)
    }

    func testTitleForHeader() {
        tableStoreSpy.sections = .fixtureRamdomList

        tableStoreSpy.sections.enumerated().forEach { (index, element) in
            let title = sut.tableView(tableSpy, titleForHeaderInSection: index)

            XCTAssertEqual(title, element.title)
        }
    }

    // MARK: cellForRow

    func testCellForRowForSectionOutOfBounds() {
        tableStoreSpy.sections = []
        let indexPath = IndexPath(row: 0, section: 1)

        let cell = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertNil(cell.textLabel?.text)
        XCTAssertNil(cell.detailTextLabel?.text)
    }

    func testCellForRowForRowOutOfBounds() {
        tableStoreSpy.sections = [
            .init(title: "", details: [])
        ]
        let indexPath = IndexPath(row: 1, section: 0)

        let cell = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertNil(cell.textLabel?.text)
        XCTAssertNil(cell.detailTextLabel?.text)
    }

    func testCellForRow() {
        tableStoreSpy.sections = .fixtureRamdomList

        tableStoreSpy.sections.enumerated().forEach { (sectionIndex, section) in

            section.details.enumerated().forEach { (rowIndex, row) in

                let indexPath = IndexPath(
                    row: rowIndex,
                    section: sectionIndex
                )

                let cell = sut.tableView(tableSpy, cellForRowAt: indexPath)

                XCTAssertEqual(cell.selectionStyle, .none)
                XCTAssertEqual(cell.textLabel?.text, row.title)
                XCTAssertEqual(cell.detailTextLabel?.text, row.subtitle)
            }
        }
    }

    // MARK: dequeueReusableCell

    func testDontDequeueReusableCellForSectionOutOfBounds() {
        tableStoreSpy.sections = []
        let indexPath = IndexPath(row: 0, section: 1)

        let _ = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertEqual(tableSpy.dequeueReusableCellCalled, false)
    }

    func testDontDequeueReusableCellForRowOutOfBounds() {
        tableStoreSpy.sections = [
            .init(title: "", details: [])
        ]
        let indexPath = IndexPath(row: 1, section: 0)

        let _ = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertEqual(tableSpy.dequeueReusableCellCalled, false)
    }

    func testDequeueReusableCellForCellWithSubtitle() {
        tableStoreSpy.sections = [
            .init(
                title: "",
                details: [.init(title: "", subtitle: "")]
            )
        ]

        let indexPath = IndexPath(row: 0, section: 0)

        let _ = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertEqual(tableSpy.dequeueReusableCellCalled, true)
        XCTAssertEqual(tableSpy.identifierPassed, "cellWithSubtitle")
        XCTAssertNil(tableSpy.indexPathPassed)
    }

    func testDequeueReusableCellForCellWithoutSubtitle() {
        tableStoreSpy.sections = [
            .init(
                title: "",
                details: [.init(title: "", subtitle: nil)]
            )
        ]

        let indexPath = IndexPath(row: 0, section: 0)

        let _ = sut.tableView(tableSpy, cellForRowAt: indexPath)

        XCTAssertEqual(tableSpy.dequeueReusableCellCalled, true)
        XCTAssertEqual(tableSpy.identifierPassed, "cellWithoutSubtitle")
        XCTAssertNil(tableSpy.indexPathPassed)
    }
}

// MARK: - Fixtures

private extension Array where Element == HeroDetailSectionModel {
    static var fixtureRamdomList: [HeroDetailSectionModel] {
        let number = (0..<3).randomElement() ?? 0
        return fixtureList.dropLast(number)
    }

    static var fixtureList: [HeroDetailSectionModel] {
        return (0..<3).map(HeroDetailSectionModel.init)
    }
}

private extension HeroDetailSectionModel {
    init(_ index: Int) {
        self.init(title: "title \(index)", details: .fixtureList)
    }
}

private extension Array where Element == HeroDetailCellModel {

    static var fixtureRamdomList: [HeroDetailCellModel] {
        let number = (0..<3).randomElement() ?? 0
        return fixtureList.dropLast(number)
    }

    static var fixtureList: [HeroDetailCellModel] {
        return (0...3).map(HeroDetailCellModel.init)
    }
}

private extension HeroDetailCellModel {
    init(_ index: Int) {
        self.init(title: "title \(index)", subtitle: "subtitle \(index)")
    }
}
