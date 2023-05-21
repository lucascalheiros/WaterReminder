//
//  WaterPercentageView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift

class WaterPercentageHeaderView: UICollectionViewCell {

    var disposeBag = DisposeBag()

    private lazy var circleView: CircularProgressView = {
        let circleView = CircularProgressView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }()

    private lazy var percentageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .blue
        label.textAlignment = .center
        label.text = "%"
        return label
    }()

    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circleView)
        addSubview(percentageLabel)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(percentageValueLabel)
        labelStackView.addArrangedSubview(secondaryLabel)

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 2/3),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),
            percentageLabel.leadingAnchor.constraint(equalTo: percentageValueLabel.trailingAnchor),
            percentageLabel.bottomAnchor.constraint(equalTo: percentageValueLabel.bottomAnchor, constant: -10),
            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])

        layer.cornerRadius = 8
        backgroundColor = .white.withAlphaComponent(0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
         super.prepareForReuse()

         disposeBag = DisposeBag()
     }

    func setPercentage(percentage: CGFloat, animationDuration: Double = 0.0) {
        percentageValueLabel.text = String(Int(percentage * 100))
        circleView.setPercentage(percentage: percentage, animationDuration: animationDuration)
    }

    func setSecondaryText(text: String) {
        secondaryLabel.text = text
    }
}
