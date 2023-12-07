//
//  WeekDaysEnum.swift
//  Settings
//
//  Created by Lucas Calheiros on 02/12/23.
//

public enum WeekDaysEnum: Int, CaseIterable, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    public var exhibitionName: String {
        get {
            switch self {

            case .sunday:
                String(localized: "generic.sunday", table: "Notification")
            case .monday:
                String(localized: "generic.monday", table: "Notification")
            case .tuesday:
                String(localized: "generic.tuesday", table: "Notification")
            case .wednesday:
                String(localized: "generic.wednesday", table: "Notification")
            case .thursday:
                String(localized: "generic.thursday", table: "Notification")
            case .friday:
                String(localized: "generic.friday", table: "Notification")
            case .saturday:
                String(localized: "generic.saturday", table: "Notification")
            }
        }
    }
}
