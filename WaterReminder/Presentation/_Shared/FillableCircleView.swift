//
//  CircleView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit

class FillableCircleView: UIView {

    private var percentage: CGFloat = 0.0
    private let mFilledView: UIView = UIView()
    private var mHeightConstraint: NSLayoutConstraint?

    var emptyColor: UIColor = .darkGray {
        didSet {
            backgroundColor = emptyColor
        }
    }

    var filledColor: UIColor = .blue {
        didSet {
            mFilledView.backgroundColor = filledColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    private func setupView() {
        backgroundColor = emptyColor
        clipsToBounds = true
        addSubview(mFilledView)

        mFilledView.translatesAutoresizingMaskIntoConstraints = false
        mFilledView.backgroundColor = filledColor

        let hConstraint: NSLayoutConstraint =
            mFilledView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: percentage)
        mHeightConstraint = hConstraint
        NSLayoutConstraint.activate([
            mFilledView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mFilledView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            hConstraint
        ])
    }

    func setPercentage(percentage: CGFloat, animationDuration: Double = 0.0) {
        self.percentage = percentage
        updateFilledPercentage()
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }

    private func updateFilledPercentage() {
        if let oldHeightConstraint = mHeightConstraint {
            removeConstraint(oldHeightConstraint)
            oldHeightConstraint.isActive = false
        }
        let newHeightConstraint =
            mFilledView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: percentage)
        newHeightConstraint.isActive = true
        addConstraint(newHeightConstraint)
        mHeightConstraint = newHeightConstraint
    }

}
