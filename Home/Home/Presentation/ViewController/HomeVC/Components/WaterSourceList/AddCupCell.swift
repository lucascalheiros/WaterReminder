//
//  AddCupCell.swift
//  Home
//
//  Created by Lucas Calheiros on 08/02/25.
//

import Common
import UIKit
import Core

class AddCupCell: IdentifiableUICollectionViewCell {

    static let  identifier: String = "AddCupCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h2
        label.textColor = AppColorGroup.surface.onColor
        label.text = String(localized: "Add")
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addConstrainedSubviews(titleLabel)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = AppColorGroup.surface.color

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
