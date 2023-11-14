//
//  AddConstrainedSubview.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit

public extension UIView {
	func addConstrainedSubview(_ view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
	}

	func addConstrainedSubviews(_ views: UIView...) {
		views.forEach { view in addConstrainedSubview(view) }
	}
}
