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

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(SettingsSections.allCases)
        snapshot.appendItems(GeneralSectionItems.allCases.map { .general($0) }, toSection: .general)
        snapshot.appendItems(NotificationSectionItems.allCases.map { .notification($0) }, toSection: .notification)
        snapshot.appendItems(ProfileSectionItems.allCases.map { .profile($0) }, toSection: .profile)
        diffableDatasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            tableView: self.tableView,
            cellProvider: { (tableView, indexPath, item) ->
                UITableViewCell? in
                let cell: UITableViewCell
                switch item {

                case .general(let generalItem):
                    switch generalItem {

                    case GeneralSectionItems.dailyWaterVolume:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindDailyWaterGoalCell(generalItem))

                    case GeneralSectionItems.volumeFormat:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindVolumeFormat(generalItem))

                    case GeneralSectionItems.theme:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindTheme(generalItem))
                    }

                case .notification(let notificationItem):
                    switch notificationItem {

                    case NotificationSectionItems.notificationEnabled:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindNotificationEnabledCell(notificationItem))

                    case NotificationSectionItems.manageNotifications:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindManageNotificationsCell(notificationItem))
                    }

                case .profile(let profileItem):
                    switch profileItem {
                        
                    case ProfileSectionItems.weight:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindWeightCell(profileItem))

                    case ProfileSectionItems.activityLevel:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindActivityLevelCell(profileItem))

                    case ProfileSectionItems.temperatureLevel:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindTemperatureLevelCell(profileItem))

                    case ProfileSectionItems.calculatedIntake:
                        cell = tableView.dequeueIdentifiableCell(indexPath, self.bindCalculatedIntateCell(profileItem))
                    }
                }
                cell.selectionStyle = .none
                return cell
            })
        return dataSource
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        let header = SettingsSectionHeaderView()
        header.setTitle(text: SettingsSections.allCases[sectionIndex].sectionTitle())
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
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

        case ProfileSectionItems.weight:
            self.presentWeightPicker()

        case ProfileSectionItems.calculatedIntake:
            self.presentCalculatedIntakeConfirmation()

        default:
            return
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    private func sectionItemFromIndexPath(_ indexPath: IndexPath) -> any SectionItemProtocol {
        let section = SettingsSections.allCases[indexPath.section]
        return section.sectionItems()[indexPath.row]
    }

    typealias DataSource = UITableViewDiffableDataSource<SettingsSections, SettingsItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SettingsSections, SettingsItem>
}
