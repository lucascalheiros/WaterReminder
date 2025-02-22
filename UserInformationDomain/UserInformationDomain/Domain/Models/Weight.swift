//
//  Weight.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 21/02/25.
//

public struct Weight {
    public var value: Double
    public var unit: WeightUnit {
        didSet {
            self = to(unit)
        }
    }

    public init(_ value: Double, _ unit: WeightUnit) {
        self.value = value
        self.unit = unit
    }

    public init(_ value: Int, _ unit: WeightUnit) {
        self.init(Double(value), unit)
    }

    public init(_ value: Float, _ unit: WeightUnit) {
        self.init(Double(value), unit)
    }


    public func to(_ unit: WeightUnit) -> Weight {
        let valueInKilograms = self.value * self.unit.toKilogramsFactor
        let convertedValue: Double

        switch unit {
        case .kilograms:
            convertedValue = valueInKilograms
        case .grams:
            convertedValue = valueInKilograms * 1000
        case .pounds:
            convertedValue = valueInKilograms / WeightUnit.pounds.toKilogramsFactor
        }

        return Weight(convertedValue, unit)
    }

    public var formattedValue: String {
        switch unit {

        case .grams:
            String(format: "%.0f", value)
        case .kilograms:
            String(format: "%.1f", value)
        case .pounds:
            String(format: "%.1f", value)
        }
    }

    public var formattedValueAndUnit: String {
        formattedValue + " " + unit.formatted
    }
}

public func + (lhs: Weight, rhs: Weight) -> Weight {
    let convertedRHS = rhs.to(lhs.unit)
    return Weight(lhs.value + convertedRHS.value, lhs.unit)
}

public func - (lhs: Weight, rhs: Weight) -> Weight {
    let convertedRHS = rhs.to(lhs.unit)
    return Weight(lhs.value - convertedRHS.value, lhs.unit)
}

public func * (lhs: Weight, rhs: Double) -> Weight {
    return Weight(lhs.value * rhs, lhs.unit)
}

public func / (lhs: Weight, rhs: Double) -> Weight {
    return Weight(lhs.value / rhs, lhs.unit)
}

