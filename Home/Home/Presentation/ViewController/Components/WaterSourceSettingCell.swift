//
//  WaterSourceTypeSettingCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/10/23.
//

import UIKit
import Common
import RxSwift
import Combine
import Components

class WaterSourceTypeSettingCell: IdentifiableUITableViewCell {
    var cancellableBag = Set<AnyCancellable>()

	static let identifier = "WaterSourceTypeSettingCell"

	lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        label.font = DefaultComponentsTheme.current.body
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.primary.color
        label.font = DefaultComponentsTheme.current.body.bold()
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

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellableBag.removeAll()
    }

	func prepareConfiguration() {
		preservesSuperviewLayoutMargins = false
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
        backgroundColor = DefaultComponentsTheme.current.surface.color
	}

	func prepareConstraints() {
		contentView.addConstrainedSubviews(titleLabel, detailLabel)

		NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			detailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}

}
