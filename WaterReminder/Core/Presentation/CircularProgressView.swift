//
//  CircleView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit

class CircularProgressView: UIView {

	private let mFilledView: UIView = UIView()

	private let mStartPoint = CGFloat(-Double.pi / 2)
	private let mEndPoint = CGFloat(3 * Double.pi / 2)

	private var mEmptyCircleLayer = CAShapeLayer()
    private var mNextShapeLayer = CAShapeLayer()
	private var mProgressShapeDict: [CGColor: CAShapeLayer] = [:]
	private var mPercentageAndColorList: [PercentageAndColor] = []

	private var mPercentage: CGFloat = 0.0

	var lineWidth = 20.0 {
		didSet {
			createCircularPath()
		}
	}

	var emptyColor: UIColor = .white {
		didSet {
			createCircularPath()
		}
	}

	var filledColor: UIColor = .blue {
		didSet {
			createCircularPath()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		createCircularPath()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		createCircularPath()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		createCircularPath()
	}

	func createCircularPath() {
		addCircleShapeLayer(shapeLayer: mEmptyCircleLayer, color: emptyColor.cgColor, drawPercentage: 1.0)
        addCircleShapeLayer(shapeLayer: mNextShapeLayer, color: emptyColor.cgColor, drawPercentage: 0)
        var percentageDrawed: CGFloat = 0
		mPercentageAndColorList.map { percentageAndColor in
            let shape = mProgressShapeDict[percentageAndColor.color] ?? {
                let tempShapeLayer = mNextShapeLayer
                mNextShapeLayer = CAShapeLayer()
                return tempShapeLayer
            }()
            mProgressShapeDict[percentageAndColor.color] = shape
            percentageDrawed += percentageAndColor.percentage
            return CircleShapeParams(shapeLayer: shape, color: percentageAndColor.color, drawPercentage: percentageDrawed)
        }.reversed().forEach {
            addCircleShapeLayer(shapeLayer: $0.shapeLayer, color: $0.color, drawPercentage: $0.drawPercentage)
        }
	}


	func circularPath() -> UIBezierPath {
		return UIBezierPath(
			arcCenter: CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0),
			radius: (bounds.width - lineWidth) / 2,
			startAngle: mStartPoint,
			endAngle: mEndPoint,
			clockwise: true
		)
	}

	func addCircleShapeLayer(shapeLayer: CAShapeLayer, color: CGColor, drawPercentage: CGFloat) {
		shapeLayer.path = circularPath().cgPath
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		shapeLayer.lineWidth = lineWidth
		shapeLayer.strokeEnd = drawPercentage
		shapeLayer.strokeColor = color
		layer.addSublayer(shapeLayer)
	}

	func setPercentage(_ percentageAndColorList: [PercentageAndColor], animationDuration: Double = 0.0) {
		self.mPercentageAndColorList = percentageAndColorList
		createCircularPath()
		UIView.animate(withDuration: animationDuration) {
			self.layoutIfNeeded()
		}
	}

    struct CircleShapeParams {
        let shapeLayer: CAShapeLayer
        let color: CGColor
        let drawPercentage: CGFloat
    }

}

struct PercentageAndColor {
	let percentage: CGFloat
	let color: CGColor
}
