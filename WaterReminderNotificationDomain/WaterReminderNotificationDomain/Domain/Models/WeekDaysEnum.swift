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
                String(localized: "generic.sunday")
            case .monday:
                String(localized: "generic.monday")
            case .tuesday:
                String(localized: "generic.tuesday")
            case .wednesday:
                String(localized: "generic.wednesday")
            case .thursday:
                String(localized: "generic.thursday")
            case .friday:
                String(localized: "generic.friday")
            case .saturday:
                String(localized: "generic.saturday")
            }
        }
    }
}
