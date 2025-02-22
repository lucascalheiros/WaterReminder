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
import Combine
import Common

class WaterPercentage: ProgrammaticView {
    var cancellableBag: Set<AnyCancellable> = []

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
        addConstrainedSubviews(circleView, percentageLabel, labelStackView, secondaryFormatLabel)
        labelStackView.addConstrainedArrangedSubviews(percentageValueLabel, secondaryLabel)

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),
            circleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            circleView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40),

            percentageLabel.leadingAnchor.constraint(equalTo: percentageValueLabel.trailingAnchor),
            percentageLabel.bottomAnchor.constraint(equalTo: percentageValueLabel.bottomAnchor, constant: -10),

            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            secondaryFormatLabel.leadingAnchor.constraint(equalTo: secondaryLabel.trailingAnchor),
            secondaryFormatLabel.bottomAnchor.constraint(equalTo: secondaryLabel.bottomAnchor)
        ])

        layer.cornerRadius = 8
        backgroundColor = AppColorGroup.surface.color
    }
    
    func setPercentage(_ percentageWithWaterSourceType: [PercentageForDrink], animationDuration: Double = 0.0) {
        percentageValueLabel.text = String(Int(percentageWithWaterSourceType.map { $0.percentage }.reduce(0, +) * 100))
        let percentageWithColor = percentageWithWaterSourceType.map { PercentageAndColor(percentage: CGFloat($0.percentage), color: $0.drink.color) }
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
