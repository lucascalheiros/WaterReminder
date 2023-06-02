//
//  CircleView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit

class CircularProgressView: UIView {

    private var percentage: CGFloat = 0.0 {
        didSet {
            createCircularPath()
        }
    }

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
        createCircularPath()
//        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()

//        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        createCircularPath()
//        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    func setPercentage(percentage: CGFloat, animationDuration: Double = 0.0) {
        self.percentage = percentage
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)

    func createCircularPath() {
            // created circularPath for circleLayer and progressLayer
            let circularPath = UIBezierPath(
                arcCenter: CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0),
                radius: (bounds.width - 20.0) / 2,
                startAngle: startPoint,
                endAngle: endPoint,
                clockwise: true
            )
            // circleLayer path defined to circularPath
            circleLayer.path = circularPath.cgPath
            // ui edits
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            circleLayer.lineWidth = 20.0
            circleLayer.strokeEnd = 1.0
            circleLayer.strokeColor = UIColor.white.cgColor
            // added circleLayer to layer
            layer.addSublayer(circleLayer)
            // progressLayer path defined to circularPath
            progressLayer.path = circularPath.cgPath
            // ui edits
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.lineWidth = 20.0
            progressLayer.strokeEnd = percentage
            progressLayer.strokeColor = UIColor.blue.cgColor
            // added progressLayer to layer
            layer.addSublayer(progressLayer)
        }

    func progressAnimation(duration: TimeInterval) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.toValue = 1.0
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        }
}
