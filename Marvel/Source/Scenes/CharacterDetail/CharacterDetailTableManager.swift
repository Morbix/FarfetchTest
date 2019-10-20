import UIKit

final class CharacterDetailTableManager: NSObject {

    fileprivate enum Identifier: String {
        case cellWithSubtitle, cellWithoutSubtitle
    }

    unowned let tableStore: CharacterDetailTableStore

    init(tableStore: CharacterDetailTableStore) {
        self.tableStore = tableStore
    }

    func attach(on tableView: UITableView) {
        tableView.dataSource = self
        #warning("test this")
        tableView.rowHeight = 58
    }
}

// MARK: - UITableViewDataSource

extension CharacterDetailTableManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableStore.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < tableStore.sections.count else {
            return 0
        }

        return tableStore.sections[section].details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detail = tableStore.sections[safe: indexPath.section]?.details[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let identifier: Identifier = detail.subtitle == nil ? .cellWithoutSubtitle : .cellWithSubtitle

        let cell = tableView.dequeueReusableCell(for: identifier)

        cell.selectionStyle = .none

        cell.textLabel?.text = detail.title
        cell.detailTextLabel?.text = detail.subtitle

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < tableStore.sections.count else {
            return nil
        }

        return tableStore.sections[section].title
    }
}

private extension UITableView {
    func dequeueReusableCell(for identifier: CharacterDetailTableManager.Identifier) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: identifier.rawValue)

        if let cell = cell { return cell }

        switch identifier {
        case .cellWithSubtitle:
            return UITableViewCell(style: .subtitle, reuseIdentifier: identifier.rawValue)
        case .cellWithoutSubtitle:
            return UITableViewCell(style: .default, reuseIdentifier: identifier.rawValue)
        }
    }
}
