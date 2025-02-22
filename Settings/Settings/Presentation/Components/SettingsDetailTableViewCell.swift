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
        label.font = .body
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel()
        label.textColor = AppColorGroup.primary.color
        label.font = .body.bold()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		return label
	}()

    lazy var rightArrow: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right"))
        view.tintColor = AppColorGroup.primary.color
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.isHidden = true
        return view
    }()

    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()

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
		contentView.addConstrainedSubviews(horizontalStackView)
        horizontalStackView.addConstrainedArrangedSubviews(titleLabel, detailLabel, rightArrow)

		NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 44),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}

	func dispose() {
        cancellableBag.removeAll()
		disposeBag = DisposeBag()
	}
}
