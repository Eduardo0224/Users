//
//  UITableView+Register.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

extension UITableView {

    // MARK: - Custom Functions
    func register(cell nib: String, withId id: String = "") {
        register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: id.isEmpty ? nib : id)
    }
}
