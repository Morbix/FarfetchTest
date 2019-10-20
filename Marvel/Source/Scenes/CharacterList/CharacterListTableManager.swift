import UIKit

final class CharacterListTableManager: NSObject {

    private enum Identifier: String {
        case cell
    }

    unowned let store: CharacterListTableStore
    unowned let delegate: CharacterListTableManagerDelegate

    init(store: CharacterListTableStore,
         delegate: CharacterListTableManagerDelegate) {
        self.store = store
        self.delegate = delegate
    }

    func attach(on tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.cell.rawValue)
    }

}

// MARK: - UITableViewDataSource

extension CharacterListTableManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return store.heroes.count
        } else {
            switch store.lastCellState {
            case .loading, .retry:
                return 1
            case .none:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell.rawValue, for: indexPath)

        if indexPath.section == 0 {
            if let hero = store.heroes[safe: indexPath.row] {
                cell.textLabel?.text = hero.name
                cell.textLabel?.textColor = .black
                cell.accessoryType = hero.hasDetail ? .disclosureIndicator : .none
                cell.selectionStyle = hero.hasDetail ? .gray : .none
            }
        } else {
            if store.lastCellState == .loading {
                cell.textLabel?.text = "loading_cell_message".localized()
                cell.selectionStyle = .none
            }

            if store.lastCellState == .retry {
                cell.textLabel?.text = "retry_cell_message".localized()
                cell.selectionStyle = .gray
            }

            cell.textLabel?.textColor = .lightGray
            cell.accessoryType = .none
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharacterListTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0,
            store.heroes[safe: indexPath.row]?.hasDetail == true {
            delegate.tableDidSelect(at: indexPath.row)
        }

        #warning("don't forget to implement the retry touch")
    }
}

// MARK: - UIScrollViewDelegate

extension CharacterListTableManager: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height < scrollView.frame.height {
            return
        }

        var position = scrollView.contentSize.height
        position -= scrollView.frame.height
        position -= scrollView.contentOffset.y

        let target = scrollView.frame.height/5

        if position <= target {
            delegate.tableDidReachRegionAroundTheEnd()
        }
    }
}
