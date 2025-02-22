//
//  SettingsViewController+CellBinders.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation
import UIKit
import Common
import WaterManagementDomain
import UserInformationDomain

extension SettingsVC {

    func bindDailyWaterGoalCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.dispose()
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.dailyWaterSelectorDelegate.volumeWithFormat
                .sinkUI {
                    let attributedString = NSMutableAttributedString.init(string: $0.formattedValueAndUnit)
                    detailCell.detailLabel.attributedText = attributedString
                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindVolumeFormat(_ sectionItem: any SectionItemProtocol) -> ((SettingsSelectionTableViewCell) -> Void) {
        return { detailCell in
            detailCell.dispose()
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.dailyWaterSelectorDelegate.volumeFormat
                .sinkUI {currentFormat in
                    var menuChildren: [UIMenuElement] = []
                    for format in SystemFormat.allCases {
                        menuChildren.append(UIAction(
                            title: format.localizedFullDisplay,
                            state: currentFormat == format ? .on : .off,
                            handler: {_ in
                                self.settingsViewModel.dailyWaterSelectorDelegate.setFormat(format)
                            }))
                    }
                    detailCell.button.menu = UIMenu(options: .displayInline, children: menuChildren)
                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindTheme(_ sectionItem: any SectionItemProtocol) -> ((SettingsSelectionTableViewCell) -> Void) {
        return { detailCell in
            detailCell.dispose()
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.theme
                .sinkUI { currentTheme in
                    var menuChildren: [UIMenuElement] = []
                    for theme in ThemePreference.allCases {
                        menuChildren.append(UIAction(
                            title: theme.text,
                            state: currentTheme == theme ? .on : .off,
                            handler: {_ in
                                self.settingsViewModel.setTheme(theme)
                            }))
                    }
                    detailCell.button.menu = UIMenu(options: .displayInline, children: menuChildren)
                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindNotificationEnabledCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsSwitchTableViewCell) -> Void) {
        return { switchCell in
            switchCell.titleLabel.text = sectionItem.itemTitle()
            switchCell.dispose()
            switchCell.onSwitchChanged = {
                self.settingsViewModel.notificationReminderToggleDelegate.setNotificationEnabled(value: $0)
            }
            self.settingsViewModel.notificationReminderToggleDelegate.isNotificationReminderEnabled
                .sinkUI {
                    switchCell.switchView.setOn($0, animated: true)
                }.store(in: &switchCell.cancellableBag)
        }
    }

    func bindTimePeriodCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.periodSelectorDelegate.periodInterval.sinkUI {
                let attributedString = NSMutableAttributedString.init(string: $0)
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindNotificationFrequencyCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.notificationFrequencySelectorDelegate.notificationFrequency.sinkUI {
                let attributedString = NSMutableAttributedString.init(string: $0.stringValue())
                detailCell.detailLabel.attributedText = attributedString
            }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindManageNotificationsCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()
            detailCell.rightArrow.isHidden = false
        }
    }

    func bindWeightCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.weight
                .sinkUI {
                    detailCell.detailLabel.text = $0.formattedValueAndUnit
                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindActivityLevelCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsSelectionTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.activityLevel
                .compactMap { $0 }
                .sinkUI { level in
                    var menuChildren: [UIMenuElement] = []
                    for value in ActivityLevel.allCases {
                        menuChildren.append(UIAction(
                            title: value.title,
                            state: level == value ? .on : .off,
                            handler: {_ in
                                self.settingsViewModel.setActivityLevel(value)
                            }))
                    }
                    detailCell.button.menu = UIMenu(options: .displayInline, children: menuChildren)

                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindTemperatureLevelCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsSelectionTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.temperature.compactMap { $0 }
                .sinkUI { level in
                    var menuChildren: [UIMenuElement] = []
                    for value in AmbienceTemperatureLevel.allCases {
                        menuChildren.append(UIAction(
                            title: value.title,
                            state: level == value ? .on : .off,
                            handler: {_ in
                                self.settingsViewModel.setTemperatureLevel(value)
                            }))
                    }
                    detailCell.button.menu = UIMenu(options: .displayInline, children: menuChildren)
                }.store(in: &detailCell.cancellableBag)
        }
    }

    func bindCalculatedIntateCell(_ sectionItem: any SectionItemProtocol) -> ((SettingsDetailTableViewCell) -> Void) {
        return { detailCell in
            detailCell.titleLabel.text = sectionItem.itemTitle()

            self.settingsViewModel.expectedWaterIntakeVolume
                .sinkUI {
                    detailCell.detailLabel.text = $0.formattedValueAndUnit
                }.store(in: &detailCell.cancellableBag)
        }
    }
}

extension ThemePreference {
    var text: String {
        switch self {

        case .dark:
            String(localized: "Dark")

        case .light:
            String(localized: "Light")

        case .auto:
            String(localized: "Auto")

        }
    }
}


extension ActivityLevel {

    var title: String {
        switch self {

        case .none:
            String(localized: "Sedentary")
        case .light:
            String(localized: "Lightly Active")
        case .moderate:
            String(localized: "Moderately Active")
        case .heavy:
            String(localized: "Heavily Active")
        }
    }
}

extension AmbienceTemperatureLevel {
    var title: String {
        switch self {

        case .cold:
            String(localized: "Cold")
        case .moderate:
            String(localized: "Moderate")
        case .warn:
            String(localized: "Warm")
        case .hot:
            String(localized: "Hot")
        }
    }
}
