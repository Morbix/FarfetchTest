import UIKit

final class CharacterListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Marvel Heroes"
        view.backgroundColor = .systemTeal

        let tableView = UITableView()
        tableView.dataSource = self
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.frame
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension CharacterListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }
}
