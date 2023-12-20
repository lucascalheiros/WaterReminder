//
//  SettingsSwitchTableViewCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/07/23.
//

import UIKit
import RxCocoa
import RxSwift
import Core
import Common
import Combine

class SettingsSwitchTableViewCell: IdentifiableUITableViewCell {
    enum Style {
        case onlySwitch
        case switchAndDelete
    }

    static let identifier = "SettingsSwitchTableViewCell"

	var disposeBag = DisposeBag()
    var cancellableBag = Set<AnyCancellable>()

    var style: Style = .onlySwitch {
        didSet {
            switch style {

            case .onlySwitch:
                deleteBtn.isHidden = true
            case .switchAndDelete:
                deleteBtn.isHidden = false
            }
        }
    }

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = AppColorGroup.surface.onColor
		return label
	}()

	lazy var switchView: UISwitch = {
		let switchView = UISwitch()
		switchView.onTintColor = AppColorGroup.primary.color
        switchView.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
		return switchView
	}()

	lazy var deleteBtn: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(systemName: "trash"), for: .normal)
		button.setImage(UIImage(systemName: "trash.fill"), for: .highlighted)
		button.tintColor = AppColorGroup.primary.color
        button.isHidden = true
		button.addTapListener { [weak self] in
            self?.onDeleteTapped?()
		}
		return button
	}()

	lazy var rootStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.distribution = .fill
		stack.spacing = 10
		return stack
	}()

    var onDeleteTapped: (() -> Void)?
    var onSwitchChanged: ((Bool) -> Void)?

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
		contentView.addConstrainedSubviews(rootStack)
		rootStack.addConstrainedArrangedSubviews(titleLabel, switchView, deleteBtn)

		NSLayoutConstraint.activate([
			rootStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			rootStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			rootStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			rootStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
	}

	func dispose() {
		disposeBag = DisposeBag()
        cancellableBag.removeAll()
	}

	@objc private func onSwitchValueChanged(_ uiSwitch: UISwitch) {
		onSwitchChanged?(uiSwitch.isOn)
	}
}
