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

class WaterSourceTypeSettingStepperCell: IdentifiableUITableViewCell {
    var cancellableBag = Set<AnyCancellable>()

	static let identifier = "WaterSourceTypeSettingStepperCell"

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

    lazy var stepper: UIStepper = {
		let view = UIStepper()
        view.minimumValue = 0.1
        view.maximumValue = 1.2
        view.stepValue = 0.1
        view.value = 1.0
        view.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
		return view
	}()

    var value: Double = 1.0 {
        didSet {
            detailLabel.text = String(format: "%.1f", value)
            stepper.value = value
        }
    }

    var onValueChange: ((Double) -> Void)?

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
        contentView.addConstrainedSubviews(titleLabel, detailLabel, stepper)

		NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            detailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -8),

            stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        value = sender.value
        onValueChange?(sender.value)
    }
}
