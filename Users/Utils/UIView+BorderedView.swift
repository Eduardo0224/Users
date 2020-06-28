//
//  BorderedView.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

@IBDesignable
class BorderedView: UIView {

    // MARK: - @IBInspectable
    @IBInspectable var borderWitdh: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWitdh
        }
    }

    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
