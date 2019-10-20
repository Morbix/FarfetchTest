import UIKit

#warning("2 cover table manager")
final class CharacterDetailTableManager: NSObject {

    unowned let tableStore: CharacterDetailTableStore

    init(tableStore: CharacterDetailTableStore) {
        self.tableStore = tableStore
    }

    func attach(on tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.selectionStyle = .none

        guard indexPath.section < tableStore.sections.count,
            indexPath.row < tableStore.sections[indexPath.section].details.count else {
            return cell
        }

        let detail = tableStore.sections[indexPath.section].details[indexPath.row]

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
