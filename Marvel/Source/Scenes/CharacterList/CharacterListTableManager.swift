import UIKit

protocol CharacterListTableStore: class {
    var heroes: [HeroCellModel] { get }
    var lastCellState: State { get }
}

protocol CharacterListTableManagerDelegate: class {
    func tableDidReachRegionAroundTheEnd()
}

final class CharacterListTableManager: NSObject {

    unowned let store: CharacterListTableStore
    unowned let delegate: CharacterListTableManagerDelegate

    init(store: CharacterListTableStore,
         delegate: CharacterListTableManagerDelegate) {
        self.store = store
        self.delegate = delegate
    }

    /**
    Receives the UITableView that this manager will implement the Delegate & DataSource and will register all the cells.

    - Parameter UITableView: The UITableView that will be handle by this manager.
    */
    func attach(on tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == 0 {
            if store.heroes.count > indexPath.row {
                cell.textLabel?.text = store.heroes[indexPath.row].name
                cell.textLabel?.textColor = .black
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
