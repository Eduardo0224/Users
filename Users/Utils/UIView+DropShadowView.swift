//
//  DropShadowView.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

class DropShadowView: UIView {

    // MARK: - Properties
    var presetCornerRadius : CGFloat = 22.0

    override var bounds: CGRect {
        didSet {
            setupShadowPath()
        }
    }

    // MARK: - Custom Functions
    private func setupShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: presetCornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
