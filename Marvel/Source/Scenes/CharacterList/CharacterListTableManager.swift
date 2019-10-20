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
            if store.heroes.count > indexPath.row {
                cell.textLabel?.text = store.heroes[indexPath.row].name
                cell.textLabel?.textColor = .black
                cell.accessoryType = .disclosureIndicator
                #warning("think if it worth open datail only if has descripion or content to show")
            }
        } else {
            if store.lastCellState == .loading {
                cell.textLabel?.text = "loading_cell_message".localized()
            }

            #warning("don't forget to implement the retry touch")
            if store.lastCellState == .retry {
                cell.textLabel?.text = "retry_cell_message".localized()
            }

            cell.textLabel?.textColor = .lightGray
            cell.accessoryType = .none
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharacterListTableManager: UITableViewDelegate {

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
