//
//  SettingsViewController+PresentDailyWaterGoalSelector.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit

extension SettingsViewController {
	func presentDailyWaterGoalSelector() {
		let detailViewController = PeriodSelectorModalViewController(periodSelectorDelegate: settingsViewModel.periodSelectorDelegate)
		let nav = UINavigationController(rootViewController: detailViewController)
		nav.modalPresentationStyle = .pageSheet

		if let sheet = nav.sheetPresentationController {
			sheet.detents = [.medium()]
		}

		present(nav, animated: true, completion: nil)
	}
}
