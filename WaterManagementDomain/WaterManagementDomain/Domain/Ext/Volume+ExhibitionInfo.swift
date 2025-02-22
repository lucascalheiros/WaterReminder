//
//  Volume+ExhibitionInfo.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 13/02/25.
//

public extension Volume {
    var formattedValue: String {
        switch unit {

        case .milliliters:
            String(format: "%.0f", value)
        case .liters:
            String(format: "%.2f", value)
        case .oz_uk:
            String(format: "%.2f", value)
        case .oz_us:
            String(format: "%.2f", value)
        }
    }

    var formattedValueAndUnit: String {
        formattedValue + " " + unit.formatted
    }
}
