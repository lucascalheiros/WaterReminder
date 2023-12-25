//
//  DailyConsumptionCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/08/23.
//

import UIKit
import Core
import Components
import WaterManagementDomain
import Common
import Combine

class DailyConsumptionCell: UICollectionViewCell, Identifiable {
    static let identifier = "DailyConsumptionCell"
	var cancellableBag = Set<AnyCancellable>()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
		label.textColor = DefaultComponentsTheme.current.surface.onColor
		return label
	}()

	private lazy var volumeLabel: UILabel = {
		let label = UILabel()
		label.font = DefaultComponentsTheme.current.body
		label.textColor = DefaultComponentsTheme.current.surface.onColor
		return label
	}()

	private lazy var timeLabel: UILabel = {
		let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
        label.textColor = DefaultComponentsTheme.current.surface.onColor
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

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
        contentView.backgroundColor = DefaultComponentsTheme.current.surface.color
    }

    func prepareConstraints() {
        contentView.addConstrainedSubviews(titleLabel, volumeLabel, timeLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),

            volumeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            volumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            volumeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),

            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    func bind(waterConsumed: AnyPublisher<WaterConsumed?, Never>, volumeFormat: AnyPublisher<VolumeFormat?, Never>) {
        waterConsumed.combineLatest(
            volumeFormat
		).sink { [weak self] waterConsumed, volumeFormat in
            guard let waterConsumed, let volumeFormat else {
                return
            }
			self?.titleLabel.text =
				waterConsumed.waterSourceType.exhibitionName
			self?.volumeLabel.text = WaterWithFormat(
				waterInML: waterConsumed.volume,
				volumeFormat: volumeFormat
			).exhibitionValueWithFormat()
			self?.timeLabel.text =
				waterConsumed.consumptionTime.formatted(date: .omitted, time: .shortened)
			self?.titleLabel.textColor = waterConsumed.waterSourceType.color
			self?.volumeLabel.textColor = waterConsumed.waterSourceType.color
        }.store(in: &cancellableBag)
	}
}
