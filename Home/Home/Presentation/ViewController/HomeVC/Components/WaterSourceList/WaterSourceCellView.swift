//
//  WaterContainerCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Foundation
import UIKit
import Core
import WaterManagementDomain
import Common
import Combine

class WaterSourceCellView: IdentifiableUICollectionViewCell {
    static var identifier: String = "WaterSourceCellView"

    var cancellableBag = Set<AnyCancellable>()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = AppColorGroup.surface.onColor
        return label
    }()

    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .h2
        label.textColor = AppColorGroup.surface.onColor
        return label
    }()

    var volumeFormat: SystemFormat? {
        didSet {
            updateData()
        }
    }
    var waterSource: CupInfo? {
        didSet {
            updateData()
        }
    }

	func updateData() {
        guard let volumeFormat, let waterSource else {
            return
        }
        titleLabel.text = waterSource.drink.name
        volumeLabel.text = Volume(waterSource.cup.volume, .milliliters).to(volumeFormat).formattedValueAndUnit
        titleLabel.textColor = waterSource.drink.color
        volumeLabel.textColor = waterSource.drink.color
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

		contentView.addConstrainedSubviews(titleLabel, volumeLabel)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = AppColorGroup.surface.color

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			volumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			volumeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellableBag.removeAll()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct WaterSourceListener {
    var itemClickListener: WaterSourceRunnable
    var pinClickListener: WaterSourceRunnable

    internal init(
        itemClickListener: @escaping WaterSourceRunnable,
        pinClickListener: @escaping WaterSourceRunnable
    ) {
        self.itemClickListener = itemClickListener
        self.pinClickListener = pinClickListener
    }
}

typealias WaterSourceRunnable = (WaterSource) -> Void
