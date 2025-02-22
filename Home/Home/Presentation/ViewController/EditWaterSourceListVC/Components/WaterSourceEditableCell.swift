//
//  WaterSourceEditableCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/10/23.
//

import UIKit
import Core
import WaterManagementDomain
import Common
import Combine

class WaterSourceEditableCell: IdentifiableUITableViewCell {

	static let identifier = "WaterSourceEditableCell"

    var cancellableBag = Set<AnyCancellable>()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
		label.font = .body
        return label
    }()

    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
		label.font = .body
        return label
    }()

	private lazy var deleteBtn: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.setImage(UIImage(systemName: "trash.fill"), for: .highlighted)
        button.tintColor = AppColorGroup.error.color
        button.addTapListener { [weak self] in
            guard let waterSource = self?.waterSource else {
                return
            }
            self?.onDeleteWaterSource?(waterSource.cup)
        }
		return button
	}()

	private lazy var separator: UIView = {
		let separator = UIView()
		separator.backgroundColor = .lightGray
		return separator
	}()

	private lazy var rearrangeIcon: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "line.3.horizontal"))
		imageView.tintColor = AppColorGroup.primary.color
		return imageView
	}()

    var waterSource: CupInfo? {
        didSet {
            guard let waterSource else {
                return
            }
            titleLabel.text = waterSource.drink.name
            titleLabel.textColor = waterSource.drink.color
        }
    }

    var volumeFormat: SystemFormat? {
        didSet {
            guard let waterSource, let volumeFormat else {
                return
            }
            volumeLabel.text = Volume(waterSource.cup.volume, .milliliters).to(volumeFormat).formattedValueAndUnit
            volumeLabel.textColor = waterSource.drink.color
        }
    }

    var onDeleteWaterSource: ((WaterSource) -> Void)?

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

	private func prepareConfiguration() {
		contentView.backgroundColor = AppColorGroup.surface.color
		separatorInset = UIEdgeInsets.zero
		layoutMargins = UIEdgeInsets.zero
		selectionStyle = .none
	}

	private func prepareConstraints() {
		contentView.addConstrainedSubviews(titleLabel, volumeLabel, rearrangeIcon, deleteBtn, separator)

		NSLayoutConstraint.activate([
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			volumeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			volumeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
			deleteBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			deleteBtn.trailingAnchor.constraint(equalTo: separator.leadingAnchor, constant: -8),
			separator.widthAnchor.constraint(equalToConstant: 0.5),
			separator.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			separator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			separator.trailingAnchor.constraint(equalTo: rearrangeIcon.leadingAnchor, constant: -8),
			rearrangeIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			rearrangeIcon.heightAnchor.constraint(equalToConstant: 30),
			rearrangeIcon.widthAnchor.constraint(equalToConstant: 30),
			rearrangeIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -8)
		])
	}

}
