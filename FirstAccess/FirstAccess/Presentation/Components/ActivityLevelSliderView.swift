//
//  ActivityLevelSliderView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit
import Core

class ActivitySliderView: UISlider {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		minimumValue = 0
		maximumValue = 7
		value = 3
		isContinuous = false
		tintColor = AppColorGroup.primary.color
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func trackRect(forBounds bounds: CGRect) -> CGRect {
		let point = CGPoint(x: bounds.minX, y: bounds.midY)
		return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
	}

}
