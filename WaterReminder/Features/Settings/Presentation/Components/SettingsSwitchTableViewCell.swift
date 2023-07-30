//
//  SettingsSwitchTableViewCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/07/23.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsSwitchTableViewCell: UITableViewCell {
	var disposeBag = DisposeBag()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = Theme.lightBlue.accentColor
		return label
	}()

	lazy var switchView: UISwitch = {
		let switchView = UISwitch()
		switchView.onTintColor = .blue
		return switchView
	}()

	lazy var stackWrapper: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .center
		stack.distribution = .fillEqually
		stack.spacing = 10
		return stack
	}()

	lazy var mainStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		return stack
	}()

	var toggleListener = {}

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
		let viewWrapper = UIView()
		viewWrapper.addConstrainedSubviews(titleLabel, switchView)
		contentView.addConstrainedSubviews(stackWrapper)
		stackWrapper.addConstrainedArrangedSubviews(viewWrapper)

		NSLayoutConstraint.activate([
			stackWrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			viewWrapper.widthAnchor.constraint(equalTo: stackWrapper.widthAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: viewWrapper.centerYAnchor),
			switchView.centerYAnchor.constraint(equalTo: viewWrapper.centerYAnchor),
			switchView.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor, constant: -16)
		])
	}

	func dispose() {
		disposeBag = DisposeBag()
	}
}
