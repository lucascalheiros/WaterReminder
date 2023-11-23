//
//  AddWaterSourceCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/10/23.
//

import UIKit
import Core

class AddWaterSourceCell: UITableViewCell {

	static let identifier = "AddWaterSourceCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
		label.font = .body
		label.textColor = AppColorGroup.primary.color
        return label
    }()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		prepareConstraints()
    }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		contentView.backgroundColor = AppColorGroup.surface.color
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
		selectionStyle = .none
		titleLabel.text = String(localized: "editWaterSourceList.cellTitle.add")
	}

	private func prepareConstraints() {
		contentView.addConstrainedSubviews(titleLabel)

		NSLayoutConstraint.activate([
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}
}
