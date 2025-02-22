//
//  VolumeUnit+ExhibitionFormat.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 13/02/25.
//

public extension VolumeUnit {
    var formatted: String {
        switch self {
        case .milliliters:
            "ml"
        case .liters:
            "L"
        case .oz_uk:
            "oz"
        case .oz_us:
            "oz"
        }

    }
}
