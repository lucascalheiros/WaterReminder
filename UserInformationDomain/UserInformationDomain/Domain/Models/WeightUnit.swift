//
//  WeightUnit.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 21/02/25.
//

public enum WeightUnit {
    case kilograms
    case grams
    case pounds

    var toKilogramsFactor: Double {
        switch self {
        case .kilograms: return 1.0
        case .grams: return 0.001
        case .pounds: return 0.45359237
        }
    }

    public var formatted: String {
        switch self {
        case .kilograms:
            String(localized: "kg")
        case .grams:
            String(localized: "g")
        case .pounds:
            String(localized: "lb")
        }
    }
}

