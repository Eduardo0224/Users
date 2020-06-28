//
//  UsersList+SearchBar.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

// MARK: - UISearchBarDelegate
extension UsersListViewController: UISearchBarDelegate {

    // MARK: - Functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            reloadTableView()
            endEditing(searchBar)
            return
        }

        viewModel.getUser(by: searchText, onComplete: {
            self.tableView.reloadData()
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reloadTableView()
        endEditing(searchBar)
    }

    // MARK: - Custom Functions
    private func reloadTableView() {
        viewModel.resetFilteredUsersList()
        self.tableView.reloadData()
    }

    private func endEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
