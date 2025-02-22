//
//  ConsumptionSummary.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 22/02/25.
//

public struct ConsumptionSummary {
    public var expectedVolume: Volume
    public var consumedCups: [ConsumedCupInfo]

    public init(expectedVolume: Volume, consumedCups: [ConsumedCupInfo]) {
        self.expectedVolume = expectedVolume
        self.consumedCups = consumedCups
    }

    public var percentageForDrink: [PercentageForDrink] {
        let maxVolume = max(expectedVolume.to(.milliliters).value, totalConsumedVolume.value)
        return Dictionary(grouping: consumedCups, by: { $0.consumedCup.drinkId }).map { waterSourceType, waterConsumedListByType in
            let volumePerType = waterConsumedListByType.map { $0.hydrationVolume }.reduce(0.0, +)
            let percentage = volumePerType / maxVolume
            let waterConsumed = waterConsumedListByType.first!
            return PercentageForDrink(percentage: Float(percentage), drink: waterConsumed.drink)
        }.sorted(by: { $0.drink.order < $1.drink.order })
    }

    public var totalConsumedVolume: Volume {
        let volume = consumedCups.map { $0.hydrationVolume }.reduce(0, +)
        return Volume(volume, .milliliters)
    }

}
