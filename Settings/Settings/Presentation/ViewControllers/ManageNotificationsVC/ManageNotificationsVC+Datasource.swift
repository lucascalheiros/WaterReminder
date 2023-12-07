//
//  ManageNotificationsVC.swift
//  Settings
//
//  Created by Lucas Calheiros on 22/11/23.
//

import UIKit
import Common
import WaterReminderNotificationDomain

extension ManageNotificationsVC {
    func registerCells() {
        tableView.registerIdentifiableCell(SettingsSwitchTableViewCell.self)
        tableView.registerIdentifiableCell(SettingsAddItemCell.self)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SettingsSectionHeaderView()
        let section = Sections.allCases[safe: section]
        switch section {
        
        case .fixedNotifications:
            header.setTitle(text:  String(localized: "manageNotifications.section.notificationsByDay"))

        case .weekDays:
            header.setTitle(text: String(localized: "manageNotifications.section.weekDays"))

        case .none:
            return nil
        }
        return header
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = diffableDatasource.itemIdentifier(for: indexPath)
        switch sectionItem {
        case .addFixedNotification:
            manageNotificationsViewModel.addFixedNotification()
        default:
            return
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    func applySnapshot(_ items: [SectionItems], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Sections.allCases)

        for item in items {
            switch item {

            case .weekDaysItem(_):
                snapshot.appendItems([item], toSection: .weekDays)

            case .fixedNotificationItem(_), .addFixedNotification:
                snapshot.appendItems([item], toSection: .fixedNotifications)

            }
        }
        diffableDatasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            tableView: self.tableView,
            cellProvider: { (tableView, indexPath, sectionItem) ->
                UITableViewCell? in
                guard Sections.allCases[safe: indexPath.section] != nil else {
                    fatalError("Section was not found")
                }
                switch sectionItem {

                case .weekDaysItem(let weekDay):
                    return tableView.dequeueIdentifiableCell(indexPath, self.bindWeekDayModel(weekDay))

                case .fixedNotificationItem(let fixedNotification):
                    return tableView.dequeueIdentifiableCell(indexPath, self.bindFixedNotificationModel(fixedNotification))

                case .addFixedNotification:
                    return tableView.dequeueIdentifiableCell(indexPath) { (_: SettingsAddItemCell) in }
                }
            })
        return dataSource
    }
}
