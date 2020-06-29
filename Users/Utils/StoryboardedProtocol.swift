//
//  StoryboardedProtocol.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

// MARK: - Enums
enum StoryboardName: String {
    case usersList = "UsersList"
    case userDetail = "UserDetail"
}

// MARK: - Protocol
protocol Storyboarded {
    static func instantiate(from storyboardName: StoryboardName) -> Self
}

// MARK: - Protocol Extension
extension Storyboarded where Self: UIViewController {
    // MARK: - Protocol Functions
    static func instantiate(from storyboardName: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
