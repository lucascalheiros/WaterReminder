//
//  ManageNotificationsVC+CellBinders.swift
//  Settings
//
//  Created by Lucas Calheiros on 06/12/23.
//

import Foundation
import WaterReminderNotificationDomain

extension ManageNotificationsVC {

    func bindWeekDayModel(_ weekDayModel: WeekDayUIModel) -> ((SettingsSwitchTableViewCell) -> Void) {
        { (cell: SettingsSwitchTableViewCell) in
            cell.titleLabel.text = weekDayModel.weekDay.exhibitionName
            cell.switchView.isOn = weekDayModel.enabled
            cell.style = .onlySwitch
            cell.onSwitchChanged = {
                weekDayModel.enabled = $0
                self.manageNotificationsViewModel.saveWeekDayState(NotificationWeekDaysState(weekDayModel.weekDay, weekDayModel.enabled))
            }
            cell.selectionStyle = .none
        }
    }

    func bindFixedNotificationModel(_ fixedNotificationModel: FixedNotificationUIModel) -> ((SettingsSwitchTableViewCell) -> Void){
        { (cell: SettingsSwitchTableViewCell) in
            cell.titleLabel.text = fixedNotificationModel.timePeriod.hourAndMinuteAsString()
            cell.switchView.isOn = fixedNotificationModel.enabled
            cell.style = .switchAndDelete
            cell.onSwitchChanged = {
                fixedNotificationModel.enabled = $0
                self.manageNotificationsViewModel.saveFixedNotificationState(FixedNotifications(fixedNotificationModel.timePeriod, fixedNotificationModel.enabled))
            }
            cell.onDeleteTapped = {
                self.manageNotificationsViewModel.deleteFixedNotification(fixedNotificationModel.timePeriod)
            }
            cell.selectionStyle = .none
        }
    }

}
