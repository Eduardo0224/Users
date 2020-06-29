//
//  UsersListViewController.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

class UsersListViewController: UITableViewController, Storyboarded {

    // MARK: - Properties
    /// ViewModel
    private(set) var viewModel = UsersListViewModel()
    private(set) var coordinator: Coordinator?
    private var searchController = UISearchController(searchResultsController: nil)
    private let loader = UIActivityIndicatorView(style: .large)

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        setupSearchController()
        configureTableView()
        registerUserTableViewCell()
        getUsersList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(withTitle: "Users App", and: searchController)
    }

    // MARK: - Custom Functions
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.separatorColor = .clear
    }

    private func registerUserTableViewCell() {
        tableView.register(cell: Constants.userCell, withId: Constants.userCellId)
    }

    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func getUsersList() {
        show(indicator: loader)
        viewModel.getUserList(onComplete: { [weak self] in
            guard let self = self else { return }
            self.hide(indicator: self.loader)
            self.tableView.reloadData()
        }) { error in
            self.hide(indicator: self.loader)
        }
    }
}

// MARK: - Constants
extension UsersListViewController {
    struct Constants {
        static let userCell = "UserTableViewCell"
        static let userCellId = "UserCellId"
    }
}

// MARK: - IDProtocol
extension UsersListViewController: InjectDependenciesProtocol {
    func initiate<T>(with dependencies: [T]) {
        dependencies.forEach { dependency in
            switch dependency {
            case let coordinator as MainCoordinator:
                self.coordinator = coordinator
            default:
                break
            }
        }
    }
}
