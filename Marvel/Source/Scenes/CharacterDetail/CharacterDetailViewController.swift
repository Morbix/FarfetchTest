import UIKit

final class CharacterDetailViewController: UITableViewController {

    private let presenter: CharacterDetailPresenter
    private let tableManager: CharacterDetailTableManager

    init(presenter: CharacterDetailPresenter,
         tableManager: CharacterDetailTableManager) {
        self.presenter = presenter
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        tableManager.attach(on: tableView)

        presenter.viewDidLoad(view: self)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(close)
        )
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CharacterDetailViewing

extension CharacterDetailViewController: CharacterDetailViewing {

    func reloadData() {
        tableView.reloadData()
    }

    func setSceneTitle(_ title: String) {
        self.title = title
    }
}
