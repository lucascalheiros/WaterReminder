//
//  SettingsViewController+NotificationCellsBind.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift
import RxCocoa

extension SettingsViewController {

	func bindNotificationEnabledCell(switchCell: SettingsSwitchTableViewCell, sectionItem: any SectionItem) {
		switchCell.titleLabel.text = sectionItem.itemTitle()
		switchCell.dispose()
		switchCell.switchView.rx
			.controlEvent(.valueChanged)
			.withLatestFrom(switchCell.switchView.rx.value)
			.bind {
				self.settingsViewModel.setNotificationEnabled(value: $0)
			}
			.disposed(by: disposeBag)

		settingsViewModel.isNotificationReminderEnabled.subscribe(onNext: {
			switchCell.switchView.setOn($0, animated: true)
		}).disposed(by: switchCell.disposeBag)
	}

	func bindTimePeriodCell(detailCell: SettingsDetailTableViewCell, sectionItem: any SectionItem) {
		detailCell.titleLabel.text = sectionItem.itemTitle()
		detailCell.detailLabel.textColor = .blue
		detailCell.detailLabel.font = UIFont.boldSystemFont(ofSize: 16)

		settingsViewModel.periodInterval.subscribe(onNext: {
			let attributedString = NSMutableAttributedString.init(string: $0)
			detailCell.detailLabel.attributedText = attributedString
		}).disposed(by: detailCell.disposeBag)
	}

	func bindNotificationFrequencyCell(detailCell: SettingsDetailTableViewCell, sectionItem: any SectionItem) {
		detailCell.titleLabel.text = sectionItem.itemTitle()
		detailCell.detailLabel.font = UIFont.boldSystemFont(ofSize: 16)
		detailCell.detailLabel.textColor = .blue

		settingsViewModel.notificationFrequencySelectorDelegate.notificationFrequency.subscribe(onNext: {
			let attributedString = NSMutableAttributedString.init(string: $0.stringValue())
			detailCell.detailLabel.attributedText = attributedString
		}).disposed(by: detailCell.disposeBag)
	}
}
