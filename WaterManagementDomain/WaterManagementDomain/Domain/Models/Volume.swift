//
//  Volume.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 05/02/25.
//

public struct Volume {
    public var value: Double
    public var unit: VolumeUnit {
        didSet {
            self = to(unit)
        }
    }

    public init(_ value: Double, _ unit: VolumeUnit) {
        self.value = value
        self.unit = unit
    }

    public init(_ value: Int, _ unit: VolumeUnit) {
        self.init(Double(value), unit)
    }

    public init(_ value: Float, _ unit: VolumeUnit) {
        self.init(Double(value), unit)
    }

    public func to(_ system: SystemFormat) -> Volume {
        to(system.unit)
    }

    public func to(_ unit: VolumeUnit) -> Volume {
        let valueInMilliliters = self.value * self.unit.toMillilitersFactor
        let convertedValue: Double

        switch unit {
        case .milliliters:
            convertedValue = valueInMilliliters
        case .liters:
            convertedValue = valueInMilliliters / VolumeUnit.liters.toMillilitersFactor
        case .oz_uk:
            convertedValue = valueInMilliliters / VolumeUnit.oz_uk.toMillilitersFactor
        case .oz_us:
            convertedValue = valueInMilliliters / VolumeUnit.oz_us.toMillilitersFactor
        }

        return Volume(convertedValue, unit)
    }
}

public func + (lhs: Volume, rhs: Volume) -> Volume {
    let convertedRHS = rhs.to(lhs.unit)
    return Volume(lhs.value + convertedRHS.value, lhs.unit)
}

public func - (lhs: Volume, rhs: Volume) -> Volume {
    let convertedRHS = rhs.to(lhs.unit)
    return Volume(lhs.value - convertedRHS.value, lhs.unit)
}

public func * (lhs: Volume, rhs: Double) -> Volume {
    return Volume(lhs.value * rhs, lhs.unit)
}

public func / (lhs: Volume, rhs: Double) -> Volume {
    return Volume(lhs.value / rhs, lhs.unit)
}

