//
//  VolumeUnit.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 13/02/25.
//

public enum VolumeUnit {
    case milliliters
    case liters
    case oz_uk
    case oz_us

    var toMillilitersFactor: Double {
        switch self {

        case .milliliters:
            1
        case .liters:
            1000
        case .oz_uk:
            28.4131
        case .oz_us:
            29.5735
        }
    }

    public var system: SystemFormat {
        switch self {

        case .milliliters:
                .metric
        case .liters:
                .metric
        case .oz_uk:
                .imperial_uk
        case .oz_us:
                .imperial_us
        }

    }
}
