//
//  UITableView+EmptyView.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

extension UITableView {

    // MARK: - Enums
    enum EmptyView: String {
        case noUsers = "UsersEmptyList"
    }

    // MARK: - Custom Functions
    func removeEmptyView() {
        backgroundView = nil
    }
    
    func setEmptyView(withName emptyView: EmptyView) {
        let view = UINib(nibName: emptyView.rawValue, bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
        view.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = view
    }
}

