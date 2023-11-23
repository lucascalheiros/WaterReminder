//
//  UIEdgeInsets+Shorthand.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

public extension UIEdgeInsets {
    func horizontalPadding() -> CGFloat {
        return right + left
    }

    func verticalPadding() -> CGFloat {
        return top + bottom
    }

    func horizontal(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: inset, bottom: bottom, right: inset)
    }

    func vertical(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: left, bottom: inset, right: right)
    }

	func left(inset: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: top, left: inset, bottom: bottom, right: right)
	}

    static func set(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    static func horizontal(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    static func vertical(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }
}
