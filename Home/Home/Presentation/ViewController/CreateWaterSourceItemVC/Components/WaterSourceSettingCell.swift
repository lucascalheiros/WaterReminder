//
//  WaterSourceTypeSettingCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/10/23.
//

import UIKit
import Core
import Common
import RxSwift
import Combine

class WaterSourceTypeSettingCell: IdentifiableUITableViewCell {
    var cancellableBag = Set<AnyCancellable>()
    var disposeBag = DisposeBag()

	static let identifier = "WaterSourceTypeSettingCell"

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColorGroup.surface.onColor
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel()
        label.textColor = AppColorGroup.surface.onColor
        label.font = .body
		return label
	}()

	lazy var rightArrow: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

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
        disposeBag = DisposeBag()
    }

	func prepareConfiguration() {
		preservesSuperviewLayoutMargins = false
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
		backgroundColor = AppColorGroup.surface.color
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

}
