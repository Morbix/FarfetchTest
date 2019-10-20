import UIKit

protocol CharacterListTableManagerDelegate: class {
    func tableDidReachRegionAroundTheEnd()
}

final class CharacterListTableManager: NSObject {

    enum State {
        case loading, retry, hidden
    }

    var lastCellState: State = .hidden
    var heroes: [HeroCellModel] = .init()
    weak var delegate: CharacterListTableManagerDelegate?

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
            return heroes.count
        } else {
            switch lastCellState {
            case .loading, .retry:
                return 1
            case .hidden:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == 0 {
            if heroes.count > indexPath.row {
                cell.textLabel?.text = heroes[indexPath.row].name
            }
        } else {
            if lastCellState == .loading {
                cell.textLabel?.text = "loading_cell_message".localized()
            }

            if lastCellState == .retry {
                cell.textLabel?.text = "retry_cell_message".localized()
            }
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

        //let target = scrollView.contentSize.height/10
        let target = scrollView.frame.height/10

        if position < target {
            delegate?.tableDidReachRegionAroundTheEnd()
        }
    }
}
