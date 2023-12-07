//
//  SettingsViewController+CellBinders.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift
import RxCocoa
import Common

extension SettingsVC {
    func bindDailyWaterGoalCell(_ sectionItem: any SectionItem) -> ((SettingsDetailTableViewCell) -> Void) {
         return { detailCell in
            detailCell.dispose()
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.detailLabel.font = .body
            detailCell.detailLabel.textColor = .blue

             self.settingsViewModel.dailyWaterSelectorDelegate.volumeWithFormat.subscribe(onNext: {
                let attributedString = NSMutableAttributedString.init(string: $0.exhibitionValueWithFormat())
                detailCell.detailLabel.attributedText = attributedString
            }).disposed(by: detailCell.disposeBag)
        }
    }

    func bindNotificationEnabledCell(_ sectionItem: any SectionItem) -> ((SettingsSwitchTableViewCell) -> Void) {
        return { switchCell in
            switchCell.titleLabel.text = sectionItem.itemTitle()
            switchCell.dispose()
            switchCell.switchView.rx
                .controlEvent(.valueChanged)
                .withLatestFrom(switchCell.switchView.rx.value)
                .bind {
                    self.settingsViewModel.notificationReminderToggleDelegate.setNotificationEnabled(value: $0)
                }
                .disposed(by: self.disposeBag)

            self.settingsViewModel.notificationReminderToggleDelegate.isNotificationReminderEnabled.sink {
                switchCell.switchView.setOn($0, animated: true)
            }.store(in: &switchCell.bag)
        }
    }

    func bindTimePeriodCell(_ sectionItem: any SectionItem) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.detailLabel.textColor = .blue
            detailCell.detailLabel.font = .body

            self.settingsViewModel.periodSelectorDelegate.periodInterval.sink {
                let attributedString = NSMutableAttributedString.init(string: $0)
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.bag)
        }
    }

    func bindNotificationFrequencyCell(_ sectionItem: any SectionItem) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.detailLabel.font = .body
            detailCell.detailLabel.textColor = .blue

            self.settingsViewModel.notificationFrequencySelectorDelegate.notificationFrequency.sink {
                let attributedString = NSMutableAttributedString.init(string: $0.stringValue())
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.bag)
        }
    }

    func bindManageNotificationsCell(_ sectionItem: any SectionItem) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
        }
    }
}
