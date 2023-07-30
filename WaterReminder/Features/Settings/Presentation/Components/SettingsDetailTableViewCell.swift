//
//  SettingsExpandableTableViewCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsDetailTableViewCell: UITableViewCell {
	var disposeBag = DisposeBag()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = Theme.lightBlue.accentColor
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textColor = Theme.lightBlue.accentColor
		return label
	}()

	lazy var rightArrow: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		preservesSuperviewLayoutMargins = false
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
		backgroundColor = Theme.lightBlue.mainColor
		prepareConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func prepareConstraints() {
		contentView.addConstrainedSubviews(titleLabel, detailLabel, rightArrow)

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			detailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			detailLabel.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -8),
			rightArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			rightArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}

	func dispose() {
		disposeBag = DisposeBag()
	}
}
