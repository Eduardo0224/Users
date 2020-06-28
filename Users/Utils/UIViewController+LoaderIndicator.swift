//
//  UIViewController+LoaderIndicator.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

extension UIViewController {

    // MARK: - Custom Functions
    func show(indicator: UIActivityIndicatorView) {
        self.view.isUserInteractionEnabled = false
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
        indicator.startAnimating()
    }

    func hide(indicator: UIActivityIndicatorView) {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
}
