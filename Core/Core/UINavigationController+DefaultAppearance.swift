//
//  UINavigationController+DefaultAppearance.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 13/08/23.
//

import UIKit
import Components

public extension UINavigationController {
    func setDefaultAppearance(titleColor: UIColor? = nil) {
		let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = DefaultComponentsTheme.current.background.color.withAlphaComponent(0.6)
		navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColor ?? DefaultComponentsTheme.current.background.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.screenTitle
        ]
        self.navigationBar.prefersLargeTitles = true
		self.navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.isTranslucent = true
	}

    func setModalAppearance(titleColor: UIColor? = nil) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = DefaultComponentsTheme.current.background.color
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColor ?? DefaultComponentsTheme.current.background.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.screenTitle
        ]
        self.navigationBar.standardAppearance = navigationBarAppearance
    }
}
