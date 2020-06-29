//
//  UIViewController+NavigationBar.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

extension UIViewController {

    // MARK: - Custom Functions
    func setupNavigationBar(withTitle title: String, and searchController: UISearchController) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .default
        let navigationBarTitleTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: #colorLiteral(red: 0.2666666667, green: 0.2745098039, blue: 0.4117647059, alpha: 1) ,
                                                                                .font : UIFont(name: "Futura-Bold",
                                                                                               size: 25) as Any]
        navigationController.navigationBar.titleTextAttributes = navigationBarTitleTextAttributes
        navigationController.navigationBar.largeTitleTextAttributes = navigationBarTitleTextAttributes
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.2666666667, green: 0.2745098039, blue: 0.4117647059, alpha: 1)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationItem.title = title

        navigationItem.searchController = searchController
        guard let searchController = navigationItem.searchController else { return }
        searchController.searchBar.searchTextField.defaultTextAttributes = [.foregroundColor: #colorLiteral(red: 0.2666666667, green: 0.2745098039, blue: 0.4117647059, alpha: 1) ,
                                                                            .font : UIFont(name: "Futura-Medium",
                                                                                           size: 20) as Any]
        searchController.searchBar.searchTextField.backgroundColor = .white
    }

    func setupNavigationBar(withTitle title: String) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.shadowImage = UIImage()
        navigationItem.title = title
    }
}
