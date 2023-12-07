//
//  SettingsAddItemCell.swift
//  Settings
//
//  Created by Lucas Calheiros on 01/12/23.
//

import UIKit
import Core
import Common

class SettingsAddItemCell: IdentifiableUITableViewCell {

    static let identifier = "SettingsAddItemCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textColor = AppColorGroup.surface.onColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareConfiguration()
        prepareConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareConfiguration() {
        contentView.backgroundColor = AppColorGroup.surface.color
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        selectionStyle = .none
        titleLabel.text = SettingsString.addFixedNotificationsAdd.string()
    }

    private func prepareConstraints() {
        contentView.addConstrainedSubviews(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
