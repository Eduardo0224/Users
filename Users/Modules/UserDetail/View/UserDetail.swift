//
//  UserDetailViewController.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

class UserDetailViewController: UIViewController, Storyboarded {

    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var postsTableView: UITableView!

    // MARK: - Properties
    /// ViewModel
    private(set) var viewModel = UserDetailViewModel()
    private(set) var coordinator: Coordinator?
    private(set) var user: User?
    private let loader = UIActivityIndicatorView(style: .large)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(withTitle: "")
        configureTableView()
        registerUserTableViewCell()
        guard let user = user else { return }
        viewModel.user = user
        configure(by: user)
        getPosts(of: user)
    }

    // MARK: - Custom Functions
    private func configure(by user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
    }

    private func configureTableView() {
        postsTableView.dataSource = self
        postsTableView.keyboardDismissMode = .onDrag
        postsTableView.tableFooterView = UIView(frame: .zero)
        postsTableView.tableHeaderView = UIView(frame: .zero)
        postsTableView.separatorColor = .clear
    }

    private func registerUserTableViewCell() {
        postsTableView.register(cell: Constants.postCell, withId: Constants.postCellId)
    }

    private func getPosts(of user: User) {
        show(indicator: loader)
        viewModel.getPostsList(by: user.id, onComplete: { [weak self] in
            guard let self = self else { return }
            self.hide(indicator: self.loader)
            self.postsTableView.reloadData()
        }) { error in
            self.hide(indicator: self.loader)
        }
    }
}

// MARK: - Constants
extension UserDetailViewController {
    struct Constants {
        static let postCell = "PostTableViewCell"
        static let postCellId = "PostCellId"
    }
}

// MARK: - IDProtocol
extension UserDetailViewController: InjectDependenciesProtocol {
    func initiate<T>(with dependencies: [T]) {
        dependencies.forEach { dependency in
            switch dependency {
            case let coordinator as MainCoordinator:
                self.coordinator = coordinator
            case let user as User:
                self.user = user
            default:
                break
            }
        }
    }
}
