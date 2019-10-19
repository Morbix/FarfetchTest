import UIKit

final class CharacterListTableManager: NSObject {

    var heroes: [HeroCellModel] = .init()

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
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if heroes.count > indexPath.row {
            cell.textLabel?.text = heroes[indexPath.row].name
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
        
    }
}
