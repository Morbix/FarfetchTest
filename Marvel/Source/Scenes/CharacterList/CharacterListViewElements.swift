import UIKit

final class CharacterListViewElements {

    private let frame: CGRect

    init(parentFrame: CGRect) {
        self.frame = parentFrame
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = frame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.init(style: .large)
        spinner.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        spinner.frame = frame
        spinner.hidesWhenStopped = true
        return spinner
    }()

    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("retry_button_title".localized(), for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 1
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()

    lazy var retryLabel: UILabel = {
        let label = UILabel()
        label.text = "retry_message".localized()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var retryStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(retryLabel)
        stack.addArrangedSubview(retryButton)
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()

    lazy var emptyFeedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "empty_feedback_message".localized()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
}
