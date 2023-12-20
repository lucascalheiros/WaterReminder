//
//  SettingsViewController+Datasource.swift
//  Settings
//
//  Created by Lucas Calheiros on 22/11/23.
//

import UIKit
import Common

extension SettingsVC {
    func registerCells() {
        tableView.registerIdentifiableCell(SettingsDetailTableViewCell.self)
        tableView.registerIdentifiableCell(SettingsSwitchTableViewCell.self)
        tableView.registerIdentifiableCell(SettingsSelectionTableViewCell.self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        let section = SettingsSections.allCases[sectionIndex]
        return section.sectionItems().count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        let header = SettingsSectionHeaderView()
        header.setTitle(text: SettingsSections.allCases[sectionIndex].sectionTitle())
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let sectionItem = sectionItemFromIndexPath(indexPath)
        switch sectionItem {
            
        case GeneralSectionItems.dailyWaterVolume:
            cell = tableView.dequeueIdentifiableCell(indexPath, bindDailyWaterGoalCell(sectionItem))

        case GeneralSectionItems.volumeFormat:
            cell = tableView.dequeueIdentifiableCell(indexPath, bindVolumeFormat(sectionItem))

        case NotificationSectionItems.notificationEnabled:
            cell = tableView.dequeueIdentifiableCell(indexPath, bindNotificationEnabledCell(sectionItem))

        case NotificationSectionItems.manageNotifications:
            cell = tableView.dequeueIdentifiableCell(indexPath, bindManageNotificationsCell(sectionItem))

        default:
            fatalError("sectionItem \(sectionItem) has not been implemented")
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
        case GeneralSectionItems.dailyWaterVolume:
            self.presentDailyWaterGoalSelector()

        case GeneralSectionItems.volumeFormat:
            self.presentVolumeFormatSelector()

        case NotificationSectionItems.manageNotifications:
            self.presentNotificationManager()

        default:
            return
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    private func sectionItemFromIndexPath(_ indexPath: IndexPath) -> any SectionItemProtocol {
        let section = SettingsSections.allCases[indexPath.section]
        return section.sectionItems()[indexPath.row]
    }
}
