//
//  SettingsSelectionTableViewCell.swift
//  Settings
//
//  Created by Lucas Calheiros on 10/12/23.
//

import UIKit
import RxCocoa
import RxSwift
import Core
import Common
import Combine
import Components
import WaterManagementDomain

class SettingsSelectionTableViewCell: IdentifiableUITableViewCell {

    static let identifier = "SettingsSelectionTableViewCell"

    var cancellableBag = Set<AnyCancellable>()
    var disposeBag = DisposeBag()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.surface.onColor
		return label
	}()

	lazy var button: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.tintColor = DefaultComponentsTheme.current.primary.color
        button.titleLabel?.font = DefaultComponentsTheme.current.buttonDefault
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        return button
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

    func prepareConfiguration() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        backgroundColor = AppColorGroup.surface.color
    }

	func prepareConstraints() {
		contentView.addConstrainedSubviews(titleLabel, button, rightArrow)

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -8),
			rightArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			rightArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}

	func dispose() {
        cancellableBag.removeAll()
        disposeBag = DisposeBag()
	}
}
