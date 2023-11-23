//
//  AddConstrainedArrangedSubview.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit

public extension UIStackView {
	func addConstrainedArrangedSubview(_ view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		addArrangedSubview(view)
	}

	func addConstrainedArrangedSubviews(_ views: UIView...) {
		views.forEach { view in addConstrainedArrangedSubview(view) }
	}
}
