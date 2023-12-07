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
            header.setTitle(text: String(localized: "manageNotifications.section.notificationsByDay", table: "Settings"))

        case .weekDays:
            header.setTitle(text: String(localized: "manageNotifications.section.weekDays", table: "Settings"))

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
                    return tableView.dequeueIdentifiableCell(indexPath) { (cell: SettingsSwitchTableViewCell) in
                        cell.titleLabel.text = weekDay.weekDay.exhibitionName
                        cell.switchView.isOn = weekDay.enabled
                        cell.style = .onlySwitch
                        cell.onSwitchChanged = {
                            weekDay.enabled = $0
                            self.manageNotificationsViewModel.saveWeekDayState(NotificationWeekDaysState(weekDay.weekDay, weekDay.enabled))
                        }
                        cell.selectionStyle = .none
                    }

                case .fixedNotificationItem(let fixedNotification):
                    return tableView.dequeueIdentifiableCell(indexPath) { (cell: SettingsSwitchTableViewCell) in
                        cell.titleLabel.text = fixedNotification.timePeriod.hourAndMinuteAsString()
                        cell.switchView.isOn = fixedNotification.enabled
                        cell.style = .switchAndDelete
                        cell.onSwitchChanged = {
                            fixedNotification.enabled = $0
                            self.manageNotificationsViewModel.saveFixedNotificationState(FixedNotifications(fixedNotification.timePeriod, fixedNotification.enabled))
                        }
                        cell.onDeleteTapped = {
                            self.manageNotificationsViewModel.deleteFixedNotification(fixedNotification.timePeriod)
                        }
                        cell.selectionStyle = .none
                    }

                case .addFixedNotification:
                    return tableView.dequeueIdentifiableCell(indexPath) { (_: SettingsAddItemCell) in }
                }
            })
        return dataSource
    }

    enum Sections: CaseIterable {
        case weekDays
        case fixedNotifications
    }

    enum SectionItems: Hashable {
        case weekDaysItem(WeekDayUIModel)
        case fixedNotificationItem(FixedNotificationUIModel)
        case addFixedNotification

        static func == (lhs: ManageNotificationsVC.SectionItems, rhs: ManageNotificationsVC.SectionItems) -> Bool {
            switch lhs {

            case .weekDaysItem(let weekDay):
                switch rhs {
                case .weekDaysItem(let weekDayOther):
                    return weekDay == weekDayOther
                default:
                    return false
                }

            case .fixedNotificationItem(let fixedNotification):
                switch rhs {
                case .fixedNotificationItem(let fixedNotificationOther):
                    return fixedNotification == fixedNotificationOther
                default:
                    return false
                }
            case .addFixedNotification:
                switch rhs {
                case .addFixedNotification:
                    return true
                default:
                    return false
                }
            }
        }

    }
}
