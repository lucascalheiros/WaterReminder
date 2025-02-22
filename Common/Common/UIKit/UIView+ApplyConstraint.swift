//
//  UIView+ApplyConstraint.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit

public extension UIView {
    func constrained() -> Self {
		translatesAutoresizingMaskIntoConstraints = false
        return self
	}
}
