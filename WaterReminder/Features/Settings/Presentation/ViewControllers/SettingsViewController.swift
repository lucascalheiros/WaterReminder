//
//  RootViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift
import Common

class SettingsViewController: UITableViewController {

	let settingsSwitchTableViewCell = "SettingsSwitchTableViewCell"
	let settingsDetailTableViewCell = "SettingsDetailTableViewCell"

	let settingsViewModel: SettingsViewModel
	let disposeBag = DisposeBag()

	init(settingsViewModel: SettingsViewModel) {
		self.settingsViewModel = settingsViewModel
		super.init(style: .insetGrouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemTeal

		tableView.register(
			SettingsSwitchTableViewCell.self,
			forCellReuseIdentifier: settingsSwitchTableViewCell
		)
		tableView.register(
			SettingsDetailTableViewCell.self,
			forCellReuseIdentifier: settingsDetailTableViewCell
		)
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		SettingsSections.allCases.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
		let section = SettingsSections.allCases[sectionIndex]
		return section.sectionItems().count
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
		let viewWrapper = UIView()
		let label = UILabel()
		let section = SettingsSections.allCases[sectionIndex]

		label.text = section.sectionTitle()
		label.textColor = UIColor.white
        label.font = .sectionTitle
		viewWrapper.addConstrainedSubview(label)
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: viewWrapper.topAnchor, constant: 8),
			label.bottomAnchor.constraint(equalTo: viewWrapper.bottomAnchor, constant: -8),
			label.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor, constant: 8)
		])
		return viewWrapper
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell
		let sectionItem = sectionItemFromIndexPath(indexPath)
		switch sectionItem {
		case GeneralSectionItems.dailyWaterVolume:
			cell = tableView.dequeueReusableCell(
				withIdentifier: settingsDetailTableViewCell,
				for: indexPath
			)
			if let detailCell = cell as? SettingsDetailTableViewCell {
				bindDailyWaterGoalCell(detailCell: detailCell, sectionItem: sectionItem)
			}
		case NotificationSectionItems.notificationEnabled:
			cell = tableView.dequeueReusableCell(
				withIdentifier: settingsSwitchTableViewCell,
				for: indexPath
			)
			if let switchCell = cell as? SettingsSwitchTableViewCell {
				bindNotificationEnabledCell(switchCell: switchCell, sectionItem: sectionItem)
			}

		case NotificationSectionItems.notificationPeriod:
			cell = tableView.dequeueReusableCell(
				withIdentifier: settingsDetailTableViewCell,
				for: indexPath
			)
			if let detailCell = cell as? SettingsDetailTableViewCell {
				bindTimePeriodCell(detailCell: detailCell, sectionItem: sectionItem)
			}

		case NotificationSectionItems.notificationFrequency:
			cell = tableView.dequeueReusableCell(
				withIdentifier: settingsDetailTableViewCell,
				for: indexPath
			)
			if let detailCell = cell as? SettingsDetailTableViewCell {
				bindNotificationFrequencyCell(detailCell: detailCell, sectionItem: sectionItem)
			}

		default:
			cell = tableView.dequeueReusableCell(withIdentifier: settingsSwitchTableViewCell, for: indexPath)
		}
		cell.selectionStyle = .none

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40.0
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let sectionItem = sectionItemFromIndexPath(indexPath)
		switch sectionItem {
		case NotificationSectionItems.notificationPeriod:
			self.presentPeriodSelector()
		case NotificationSectionItems.notificationFrequency:
			self.presentFrequencySelector()
		case GeneralSectionItems.dailyWaterVolume:
			self.presentDailyWaterGoalSelector()
		default:
			return
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func sectionItemFromIndexPath(_ indexPath: IndexPath) -> any SectionItem {
		let section = SettingsSections.allCases[indexPath.section]
		return section.sectionItems()[indexPath.row]
	}
}
