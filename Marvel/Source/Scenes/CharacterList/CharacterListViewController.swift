import UIKit

final class CharacterListViewController: UIViewController {

    private let presenter: CharacterListPresenter
    private lazy var elements: CharacterListViewElements = CharacterListViewElements(
        parentFrame: view.frame
    )

    init(presenter: CharacterListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        elements.tableView.dataSource = self

        setupSubviews()
        setupRetryStackLayout()

        presenter.viewDidLoad(view: self)
    }

    // MARK: - Methods

    private func setupSubviews() {
        view.addSubview(elements.tableView)
        view.addSubview(elements.spinner)
        view.addSubview(elements.retryStack)
    }

    private func setupRetryStackLayout() {
        elements.retryStack.translatesAutoresizingMaskIntoConstraints = false
        elements.retryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        elements.retryStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        elements.retryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
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

extension CharacterListViewController: CharacterListViewing {
    func setSceneTitle(_ title: String) {
        self.title = title
    }

    func showSceneSpinner() {
        elements.spinner.startAnimating()
    }

    func removeSceneSpinner() {
        elements.spinner.stopAnimating()
    }

    func showCharacteresTable() {
        elements.tableView.isHidden = false
    }

    func hideCharactersTable() {
        elements.tableView.isHidden = true
    }

    func showRetryOption() {
        elements.retryStack.isHidden = false
    }

    func hideRetryOption() {
        elements.retryStack.isHidden = true
    }

    func showRetryCell() {

    }

    func hideRetryCell() {

    }

    func showEmptyFeeback() {

    }

    func includeCharacters(_ characters: [HeroeCellModel]) {

    }
}
