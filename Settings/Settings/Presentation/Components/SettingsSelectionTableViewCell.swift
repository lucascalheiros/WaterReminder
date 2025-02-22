//
//  SettingsSelectionTableViewCell.swift
//  Settings
//
//  Created by Lucas Calheiros on 10/12/23.
//

import UIKit
import Core
import Common
import Combine
import Components
import WaterManagementDomain

class SettingsSelectionTableViewCell: IdentifiableUITableViewCell {

    static let identifier = "SettingsSelectionTableViewCell"

    var cancellableBag = Set<AnyCancellable>()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
		return label
	}()

	lazy var button: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.tintColor = DefaultComponentsTheme.current.primary.color
        button.titleLabel?.font = DefaultComponentsTheme.current.buttonDefault
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
	}()

    lazy var rightArrow: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right"))
        view.tintColor = DefaultComponentsTheme.current.primary.color
        view.isHidden = true
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
        backgroundColor = DefaultComponentsTheme.current.surface.color
    }

	func prepareConstraints() {
        contentView.addConstrainedSubviews(horizontalStackView)
        horizontalStackView.addConstrainedArrangedSubviews(titleLabel, button, rightArrow)

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
	}
}
