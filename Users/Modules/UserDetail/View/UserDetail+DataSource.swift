//
//  UserDetail+DataSource.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

extension UserDetailViewController: UITableViewDataSource {

    // MARK: - Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let postsCount = viewModel.posts.count
        postsCount == 0 ? tableView.setEmptyView(withName: .noPosts) : tableView.removeEmptyView()
        return postsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.postCellId, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = viewModel.post(indexPath.row)
        cell.configure(with: post)
        cell.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
