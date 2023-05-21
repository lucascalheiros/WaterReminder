//
//  WaterPercentageView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit


class WaterPercentageView: CardStackView {
    
    lazy var circleView: CircularProgressView = {
        let circleView = CircularProgressView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func setup() {
        super.setup()
        axis = .vertical
        alignment = .center
        distribution = .fill
        translatesAutoresizingMaskIntoConstraints = false
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        isLayoutMarginsRelativeArrangement = true
        addArrangedSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 2/3),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),
        ])
    }
    
    func setPercentage(percentage: CGFloat, animationDuration: Double = 0.0) {
        circleView.setPercentage(percentage: percentage, animationDuration: animationDuration)
    }
}
