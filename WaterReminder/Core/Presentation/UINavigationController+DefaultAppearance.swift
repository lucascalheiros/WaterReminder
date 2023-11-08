//
//  UINavigationController+DefaultAppearance.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 13/08/23.
//

import UIKit

extension UINavigationController {
	func setDefaultAppearance() {
		let navigationBarAppearance = UINavigationBarAppearance()
		navigationBarAppearance.backgroundColor = Theme.primaryBackground.mainColor
		navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.screenTitle
        ]
		self.navigationBar.standardAppearance = navigationBarAppearance
	}
}
