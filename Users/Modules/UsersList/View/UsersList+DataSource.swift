//
//  UsersList+DataSource.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

// MARK: - UITableViewDataSource
extension UsersListViewController {

    // MARK: - Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let usersCount = viewModel.filteredUsers.count
        usersCount == 0 ? tableView.setEmptyView(withName: .noUsers) : tableView.removeEmptyView()
        return usersCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellId, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.user(indexPath.row))
        cell.postsButtonPressed = { self.coordinator?.presentDetail(of: self.viewModel.user(indexPath.row)) }
        return cell
    }
}
