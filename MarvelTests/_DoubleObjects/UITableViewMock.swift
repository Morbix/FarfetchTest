import XCTest
@testable import Marvel

final class UITableViewMock: UITableView {

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
