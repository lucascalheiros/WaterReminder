//
//  SettingsViewController+SelectHandlers.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit
import UserInformationDomain

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

    func presentWeightPicker() {
        settingsViewModel.weight.first().sinkUI { [weak self] weight in
            let alert = UIAlertController(
                title: String(localized: "Weight"),
                message: String(localized: "Enter your weight in \(weight.unit.formatted)") ,
                preferredStyle: .alert
            )
            alert.addTextField { (textField) in
                textField.keyboardType = .decimalPad
                textField.text = weight.formattedValue
                textField.textAlignment = .center
            }
            alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: { [weak alert, weak self] _ in
                guard let newValue = Double(alert?.textFields?.first?.text ?? "0") else {
                    return
                }
                guard newValue > 0 else {
                    return
                }
                self?.settingsViewModel.setWeight(Weight(newValue, weight.unit))
            }))
            alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
            self?.present(alert, animated: true, completion: nil)
        }.store(in: &cancellableBag)
    }

    func presentCalculatedIntakeConfirmation() {
        settingsViewModel.expectedWaterIntakeVolume.first().sinkUI { [weak self] volume in
            let alert = UIAlertController(
                title: String(localized: "Calculated Intake"),
                message: String(localized: "Confirm to set you current daily intake to \(volume.formattedValueAndUnit)") ,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: { [weak self] _ in
                self?.settingsViewModel.setIntake(volume)
            }))
            alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
            self?.present(alert, animated: true, completion: nil)
        }.store(in: &cancellableBag)
    }
}
