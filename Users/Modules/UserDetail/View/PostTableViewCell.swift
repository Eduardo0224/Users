//
//  PostTableViewCell.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var dropShadowView: DropShadowView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!

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

    func configure(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
