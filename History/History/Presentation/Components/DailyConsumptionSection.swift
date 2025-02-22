//
//  DailyConsumptionSection.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/08/23.
//

import UIKit
import RxSwift
import RxRelay
import Common
import Components
import WaterManagementDomain
import Combine

class DailyConsumptionSection: UICollectionReusableView {
    static let identifier = "DailyConsumptionSection"
    var cancellableBag = Set<AnyCancellable>()
	let disposeBag = DisposeBag()

    lazy var titleLabel: UILabel = {
		let label = UILabel()
        label.font = .sectionTitle
        label.textColor = DefaultComponentsTheme.current.background.onColor
		return label
	}()

	lazy var percentageLabel: UILabel = {
		let label = UILabel()
        label.font = .caption
        label.textColor = DefaultComponentsTheme.current.background.onColor
		return label
	}()

	lazy var volumeLabel: UILabel = {
		let label = UILabel()
		label.font = .caption
        label.textColor = DefaultComponentsTheme.current.background.onColor
		return label
	}()

	lazy var circularProgressView = {
		let cpv = CircularProgressView(frame: .zero)
		cpv.emptyColor = .white.withAlphaComponent(0.5)
		cpv.lineWidth = 8.0
		return cpv
	}()

    var consumptionSummary: ConsumptionSummary? {
        didSet {
            updateData()
        }
    }

    var volumeUnit: VolumeUnit? {
        didSet {
            updateData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareConstraints()
    }

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func prepareForReuse() {
        super.prepareForReuse()
    
        cancellableBag.removeAll()
        circularProgressView.clear()
    }

    private func updateData() {
        guard let consumptionSummary, let volumeUnit else { return }
        setWaterPercentage(waterPercentageData: consumptionSummary.percentageForDrink)
        setConsumedVolume(volumeWithFormat: consumptionSummary.totalConsumedVolume.to(volumeUnit))
    }

    var date: Date? {
        didSet {
            guard let date else { return }
            let today = Date()
            var dateComponent = DateComponents()
            dateComponent.day = -1
            let yesterday = Calendar.current.date(byAdding: dateComponent, to: today)!

            switch date.startOfDay {
            case today.startOfDay:
                titleLabel.text = String(localized: "generic.today")
            case yesterday.startOfDay:
                titleLabel.text = String(localized: "generic.yesterday")
            default:
                titleLabel.text = date.formatted(date: .numeric, time: .omitted)
            }
        }
    }

    func setWaterPercentage(waterPercentageData: [PercentageForDrink]) {
        self.circularProgressView.setPercentage(waterPercentageData.map { PercentageAndColor(percentage: CGFloat($0.percentage), color: $0.drink.color) })
        self.percentageLabel.text = String(format: "%.1f%%", waterPercentageData.map { $0.percentage }.reduce(0, +) * 100)
    }

    func setConsumedVolume(volumeWithFormat: Volume?) {
        if let volumeWithFormat {
            self.volumeLabel.text = volumeWithFormat.formattedValueAndUnit
        }
    }

    func prepareConstraints() {
        addConstrainedSubviews(titleLabel, circularProgressView, percentageLabel, volumeLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            circularProgressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circularProgressView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            circularProgressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            circularProgressView.widthAnchor.constraint(equalToConstant: 40.0),
            circularProgressView.heightAnchor.constraint(equalToConstant: 40.0),

            percentageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            percentageLabel.trailingAnchor.constraint(equalTo: circularProgressView.leadingAnchor, constant: -8),

            volumeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            volumeLabel.trailingAnchor.constraint(equalTo: circularProgressView.leadingAnchor, constant: -8)
        ])
    }
}
