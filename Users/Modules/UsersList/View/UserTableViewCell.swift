//
//  UserTableViewCell.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var dropShadowView: DropShadowView!

    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDropShadowView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10))
    }

    // MARK: - Custom Functions
    private func setupDropShadowView() {
        dropShadowView.layer.shadowColor = UIColor.black.cgColor
        dropShadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        dropShadowView.layer.shadowRadius = 5
        dropShadowView.layer.shadowOpacity = 0.15
        dropShadowView.layer.masksToBounds = false
    }

    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        websiteLabel.text = user.website
        phoneLabel.text = user.phone
    }
}
