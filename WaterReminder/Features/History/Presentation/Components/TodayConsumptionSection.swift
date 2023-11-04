//
//  TodayConsumptionSection.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/08/23.
//

import UIKit
import RxSwift
import RxRelay

class TodayConsumptionSection: UICollectionReusableView {
	let disposeBag = DisposeBag()
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.textColor = .white
		label.text = "Today"
		return label
	}()

	lazy var percentageLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 15.0)
		label.textColor = .white
		return label
	}()

	lazy var volumeLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 15.0)
		label.textColor = .white
		return label
	}()

	lazy var circularProgressView = {
		let cpv = CircularProgressView(frame: .zero)
		cpv.emptyColor = .white.withAlphaComponent(0.5)
		cpv.lineWidth = 8.0
		return cpv
	}()

	let percentageWithWaterSourceTypeList = BehaviorRelay<[PercentageWithWaterSourceType]>(value: [])
	let consumedVolume = BehaviorRelay<WaterWithFormat?>(value: nil)

	override init(frame: CGRect) {
		super.init(frame: frame)

		addConstrainedSubviews(titleLabel, circularProgressView, percentageLabel, volumeLabel)
		percentageWithWaterSourceTypeList.subscribe(onNext: {
            self.circularProgressView.setPercentage($0.map { PercentageAndColor(percentage: CGFloat($0.percentage), color: $0.waterSourceType.color.cgColor) })
            self.percentageLabel.text = String(format: "%.1f%%", $0.map { $0.percentage }.reduce(0, +) * 100)
		}).disposed(by: disposeBag)
		consumedVolume.subscribe(onNext: {
			if let volumeWithFormat = $0 {
				self.volumeLabel.text = volumeWithFormat.exhibitionValueWithFormat()
			}
		}).disposed(by: disposeBag)

		NSLayoutConstraint.activate([
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			circularProgressView.trailingAnchor.constraint(equalTo: trailingAnchor),
			circularProgressView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			circularProgressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			circularProgressView.widthAnchor.constraint(equalToConstant: 40.0),
			circularProgressView.heightAnchor.constraint(equalToConstant: 40.0),
			percentageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			volumeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			percentageLabel.trailingAnchor.constraint(equalTo: circularProgressView.leadingAnchor, constant: -8),
			volumeLabel.trailingAnchor.constraint(equalTo: circularProgressView.leadingAnchor, constant: -8)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
