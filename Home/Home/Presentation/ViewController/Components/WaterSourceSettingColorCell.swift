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

class WaterSourceSettingColorCell: IdentifiableUITableViewCell {
    var cancellableBag = Set<AnyCancellable>()

	static let identifier = "WaterSourceSettingColorCell"

	lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        label.font = DefaultComponentsTheme.current.body
		return label
	}()

    lazy var circleView: CircleView = {
		let view = CircleView()
        view.strokeColor = strokeColor
        view.color = color
		return view
	}()

    var color: UIColor = .blue {
        didSet {
            circleView.color = color
        }
    }

    var strokeColor: UIColor = .white {
        didSet {
            circleView.strokeColor = strokeColor
        }
    }

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
		contentView.addConstrainedSubviews(titleLabel, circleView)

		NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            circleView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            circleView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}

}
