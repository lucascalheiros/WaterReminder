//
//  SettingsExpandableTableViewCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import RxCocoa
import RxSwift
import Core
import Common
import Combine

class SettingsDetailTableViewCell: IdentifiableUITableViewCell {

    static let identifier = "SettingsDetailTableViewCell"

	var disposeBag = DisposeBag()
    var cancellableBag = Set<AnyCancellable>()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.textColor = AppColorGroup.surface.onColor
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColorGroup.surface.onColor
		return label
	}()

	lazy var rightArrow: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		preservesSuperviewLayoutMargins = false
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
		backgroundColor = AppColorGroup.surface.color
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
        cancellableBag.removeAll()
		disposeBag = DisposeBag()
	}
}
