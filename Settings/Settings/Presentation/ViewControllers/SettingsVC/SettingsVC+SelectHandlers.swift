//
//  SettingsViewController+SelectHandlers.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit

extension SettingsVC {
	func presentDailyWaterGoalSelector() {
		let detailViewController = DailyWaterSelectorModalVC(
			dailyWaterSelectorDelegate: settingsViewModel.dailyWaterSelectorDelegate
		)
		let nav = UINavigationController(rootViewController: detailViewController)
		nav.modalPresentationStyle = .pageSheet

		if let sheet = nav.sheetPresentationController {
			sheet.detents = [.medium()]
		}

		present(nav, animated: true, completion: nil)
	}

    func presentFrequencySelector() {
        let detailViewController = NotificationFrequencySelectorModalVC(
            notificationFrequencySelectorDelegate: settingsViewModel.notificationFrequencySelectorDelegate
        )
        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        present(nav, animated: true, completion: nil)
    }

    func presentPeriodSelector() {
        let detailViewController = PeriodSelectorModalVC(periodSelectorDelegate: settingsViewModel.periodSelectorDelegate)
        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        present(nav, animated: true, completion: nil)
    }

    func presentNotificationManager() {
        settingsViewModel.presentNotificationManager()
    }

    func presentVolumeFormatSelector() {
        
    }
}
