//
//  UsersListViewController.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

class UsersListViewController: UITableViewController {

    // MARK: - Properties
    /// ViewModel
    let viewModel = UsersListViewModel()
    var searchController = UISearchController(searchResultsController: nil)
    var currentSearchTask: URLSessionTask?

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
        setupSearchController()
        setupNavigationBar(withTitle: "Users App", and: searchController)
        configureTableView()
        registerUserTableViewCell()
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

}

// MARK: - Constants
extension UsersListViewController {
    struct Constants {
        static let userCell = "UserTableViewCell"
        static let userCellId = "UserCellId"
    }
}
