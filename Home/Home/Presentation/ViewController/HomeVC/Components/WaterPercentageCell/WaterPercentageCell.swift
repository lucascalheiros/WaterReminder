//
//  WaterPercentageCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift
import Components
import Core
import WaterManagementDomain

class WaterPercentageCell: UICollectionViewCell {

    var disposeBag = DisposeBag()

    private lazy var circleView: CircularProgressView = {
        let circleView = CircularProgressView()
        return circleView
    }()

    private lazy var percentageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .h1
        label.textColor = AppColorGroup.primary.color
        label.textAlignment = .center
        return label
    }()

    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = AppColorGroup.primary.color
        label.textAlignment = .center
        label.text = "%"
        return label
    }()

    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = AppColorGroup.primary.color
        label.textAlignment = .center
        return label
    }()

    private lazy var secondaryFormatLabel: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = AppColorGroup.primary.color
        label.textAlignment = .center
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

	private lazy var informativeBottomRightLabel: UILabel = {
		let label = UILabel()
        label.font = .h4
		label.textColor = AppColorGroup.surface.onColor
		label.textAlignment = .center
		return label
	}()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstrainedSubviews(circleView, percentageLabel, labelStackView, informativeBottomRightLabel, secondaryFormatLabel)
        labelStackView.addConstrainedArrangedSubviews(percentageValueLabel, secondaryLabel)

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 5/9),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),
            percentageLabel.leadingAnchor.constraint(equalTo: percentageValueLabel.trailingAnchor),
            percentageLabel.bottomAnchor.constraint(
                equalTo: percentageValueLabel.bottomAnchor,
                constant: -10
            ),
            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			informativeBottomRightLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor),
			informativeBottomRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			informativeBottomRightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			secondaryFormatLabel.leadingAnchor.constraint(equalTo: secondaryLabel.trailingAnchor),
			secondaryFormatLabel.bottomAnchor.constraint(equalTo: secondaryLabel.bottomAnchor)
        ])

        layer.cornerRadius = 8
		backgroundColor = AppColorGroup.surface.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
         super.prepareForReuse()

         disposeBag = DisposeBag()
     }

    func setPercentage(_ percentageWithWaterSourceType: [PercentageWithWaterSourceType], animationDuration: Double = 0.0) {
        percentageValueLabel.text = String(Int(percentageWithWaterSourceType.map { $0.percentage }.reduce(0, +) * 100))
        let percentageWithColor = percentageWithWaterSourceType.map { PercentageAndColor(percentage: CGFloat($0.percentage), color: $0.waterSourceType.color.cgColor) }
        circleView.setPercentage(percentageWithColor, animationDuration: animationDuration)
    }

    func setSecondaryText(text: String) {
        secondaryLabel.text = text
    }

	func setFormatText(text: String) {
		secondaryFormatLabel.text = text
	}

	func setInformativeText(text: String) {
		informativeBottomRightLabel.text = text
	}
}
