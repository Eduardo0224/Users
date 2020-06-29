//
//  Coordinator+Protocol.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

protocol Coordinator {

    // MARK: - Properties
    var navigationController: UINavigationController { get set }

    // MARK: - Protocol Functions
    func start()

    func presentDetail(of: User)
}
