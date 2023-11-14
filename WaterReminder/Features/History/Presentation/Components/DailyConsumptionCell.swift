//
//  DailyConsumptionCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/08/23.
//

import UIKit
import RxRelay
import RxSwift
import RxSwiftExt
import Core

class DailyConsumptionCell: UICollectionViewCell {
    static let identifier = "DailyConsumptionCell"
	let disposeBag = DisposeBag()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.font = .body
		label.textColor = .darkGray
		return label
	}()

	private lazy var volumeLabel: UILabel = {
		let label = UILabel()
		label.font = .body
		label.textColor = .darkGray
		return label
	}()

	private lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.font = .body
		label.textColor = .darkGray
		return label
	}()

	let waterConsumed = BehaviorRelay<WaterConsumed?>(value: nil)
	let volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addConstrainedSubviews(titleLabel, volumeLabel, timeLabel)
		contentView.backgroundColor = AppColorGroup.surface.color

		observeRelays()

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

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func observeRelays() {
		Observable.combineLatest(
			waterConsumed.unwrap(),
			volumeFormat.unwrap()
		).subscribe(onNext: { [weak self] waterConsumed, volumeFormat in
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
		}).disposed(by: disposeBag)
	}
}
