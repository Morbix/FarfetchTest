import UIKit

final class CharacterListViewController: UIViewController, Scene {

    private let presenter: CharacterListPresenter
    private let tableManager: CharacterListTableManager
    private lazy var elements: CharacterListViewElements = CharacterListViewElements(
        parentFrame: view.frame
    )

    init(presenter: CharacterListPresenter,
         tableManager: CharacterListTableManager) {
        self.presenter = presenter
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        tableManager.attach(on: elements.tableView)

        setupSubviews()
        setupRetryStackLayout()
        setupEmptyFeedbackLayout()

        presenter.viewDidLoad(view: self)
    }

    // MARK: - Methods

    private func setupSubviews() {
        view.addSubview(elements.tableView)
        view.addSubview(elements.spinner)
        view.addSubview(elements.retryStack)
        view.addSubview(elements.emptyFeedbackLabel)
    }

    private func setupRetryStackLayout() {
        elements.retryStack.translatesAutoresizingMaskIntoConstraints = false
        elements.retryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        elements.retryStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        elements.retryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }

    private func setupEmptyFeedbackLayout() {
        elements.emptyFeedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        elements.emptyFeedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        elements.emptyFeedbackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        elements.emptyFeedbackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }
}

#warning("Cover CharacterListViewing")
extension CharacterListViewController: CharacterListViewing {

    func reloadData() {
        elements.tableView.reloadData()
    }

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

    func showEmptyFeeback() {
        elements.emptyFeedbackLabel.isHidden = false
    }

    func hideEmptyFeedback() {
        elements.emptyFeedbackLabel.isHidden = true
    }
}
