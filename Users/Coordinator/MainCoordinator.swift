//
//  MainCoordinator.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let usersListViewController = UsersListViewController.instantiate(from: .usersList)
        usersListViewController.initiate(with: [self])
        navigationController.pushViewController(usersListViewController, animated: true)
    }

    func presentDetail(of user: User) {
        let userDetailViewController = UserDetailViewController.instantiate(from: .userDetail)
        userDetailViewController.initiate(with: [self, user])
        navigationController.pushViewController(userDetailViewController, animated: true)
    }
}
