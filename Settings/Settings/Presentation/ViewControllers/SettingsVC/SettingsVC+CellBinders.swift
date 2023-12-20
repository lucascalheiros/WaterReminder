//
//  SettingsViewController+CellBinders.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift
import RxCocoa
import Common
import WaterManagementDomain

extension SettingsVC {
    func bindDailyWaterGoalCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
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

    func bindVolumeFormat(_ sectionItem: any SectionItemProtocol) -> ((SettingsSelectionTableViewCell) -> Void) {
         return { detailCell in
            detailCell.dispose()
            detailCell.titleLabel.text = sectionItem.itemTitle()

             self.settingsViewModel.dailyWaterSelectorDelegate.volumeFormat.subscribe(onNext: {currentFormat in
                 var menuChildren: [UIMenuElement] = []
                 for format in VolumeFormat.allCases {
                     menuChildren.append(UIAction(
                        title: format.localizedDisplay,
                        state: currentFormat == format ? .on : .off,
                        handler: {_ in
                         self.settingsViewModel.dailyWaterSelectorDelegate.setFormat(format)
                     }))
                 }
                 detailCell.button.menu = UIMenu(options: .displayInline, children: menuChildren)
             }).disposed(by: detailCell.disposeBag)
        }
    }

    func bindNotificationEnabledCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsSwitchTableViewCell) -> Void) {
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
            }.store(in: &switchCell.cancellableBag)
        }
    }

    func bindTimePeriodCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.detailLabel.textColor = .blue
            detailCell.detailLabel.font = .body

            self.settingsViewModel.periodSelectorDelegate.periodInterval.sink {
                let attributedString = NSMutableAttributedString.init(string: $0)
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindNotificationFrequencyCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.detailLabel.font = .body
            detailCell.detailLabel.textColor = .blue

            self.settingsViewModel.notificationFrequencySelectorDelegate.notificationFrequency.sink {
                let attributedString = NSMutableAttributedString.init(string: $0.stringValue())
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindManageNotificationsCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
        }
    }
}
