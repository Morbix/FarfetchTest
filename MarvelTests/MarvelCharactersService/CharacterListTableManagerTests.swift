import XCTest
@testable import Marvel

final class CharacterListTableManagerTests: XCTestCase {

    private let tableSpy = TableViewSpy()
    private let sut = CharacterListTableManager()

    func testStartWithEmptyHeroes() {
        XCTAssertEqual(sut.heroes.isEmpty, true)
    }

    // MARK: Attach

    func testAttach() {
        XCTAssertNil(tableSpy.dataSource)

        sut.attach(on: tableSpy)

        XCTAssertTrue(tableSpy.dataSource === sut)
        XCTAssertEqual(tableSpy.registerCalled, true)
        XCTAssertEqual(tableSpy.cellClasses.containsClass(UITableViewCell.self), true)
        XCTAssertEqual(tableSpy.identifiers.contains("Cell"), true)
    }

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

// MARK: - HeroCellModel Dummy
private extension HeroCellModel {
    init(_ index: Int) {
        self.init(name: "Hero \(index)")
    }
}

// MARK: - HeroCellModel Fixtures

private extension HeroCellModel {
    static var fixtureRamdomList: [HeroCellModel] {
        let number = (0..<3).randomElement() ?? 0
        return fixtureList.dropLast(number)
    }

    static var fixtureList: [HeroCellModel] {
        return (0..<3).map(HeroCellModel.init)
    }
}

// MARK: - TableViewSpy

private class TableViewSpy: UITableView {
    private(set) var registerCalled: Bool = false
    private(set) var cellClasses: [AnyClass] = []
    private(set) var identifiers: [String] = []
    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        registerCalled = true
        if let cellClass = cellClass {
            cellClasses.append(cellClass)
        }
        identifiers.append(identifier)
    }

    private(set) var dequeueReusableCellCalled: Bool = false
    private(set) var identifierPassed: String? = nil
    private(set) var indexPathPassed: IndexPath? = nil
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellCalled = true
        identifierPassed = identifier
        indexPathPassed = indexPath
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
}
