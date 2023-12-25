//
//  HistoryChartViewModel.swift
//  History
//
//  Created by Lucas Calheiros on 25/12/23.
//

import Foundation
import Combine
import WaterManagementDomain

class HistoryChartViewModel: ObservableObject {
    @Published var expectedWaterVolume: Float?
    @Published var volumeFormat: VolumeFormat?
    @Published var waterConsumedList: [WaterConsumed] = []
    @Published var historyPeriod: HistoryPeriod = .week

    var expectedWaterVolumeFormatted: Float {
        volumeFormat?.fromMetric(expectedWaterVolume ?? 0) ?? 0
    }

    var dailyWaterIntake: [WaterIntake] {
        guard let volumeFormat else {
            return []
        }
        return WaterIntake.fromWaterConsumedList(waterConsumedList, volumeFormat)
    }

    var monthlyAverageWaterIntake: [WaterIntake] {
        let averageMonthParticipationIntake = Dictionary(grouping: dailyWaterIntake, by: {
            DateComponents(year: $0.date.year, month: $0.date.month)
        }).map { (key: DateComponents, value: [WaterIntake]) in
            let uniqueDays = Set(value.map { $0.date }).count.toFloat()
            return value.map { waterIntake in
                WaterIntake(
                    date: key,
                    volume: waterIntake.volume / uniqueDays,
                    waterSourceType: waterIntake.waterSourceType)
            }
        }.joined()
        return Dictionary(grouping: averageMonthParticipationIntake, by: {
            GroupingKey(date: DateComponents(year: $0.date.year, month: $0.date.month),  waterSourceType: $0.waterSourceType)
        }).map { (key, value) in
            WaterIntake(
                date: key.date,
                volume: value.map { $0.volume }.reduce(0, +),
                waterSourceType: key.waterSourceType)
        }.sorted(by: { $0.volume > $1.volume })
    }

     var waterIntakeList: [WaterIntake] {
        switch historyPeriod {
        case .month, .week:
            dailyWaterIntake
        case .year:
            monthlyAverageWaterIntake
        }
    }

    var datesShown: [Date] {
        let currentTime = Date().startOfDay
        switch historyPeriod {
        case .week, .month:
           return (0...historyPeriod.rawValue).map { Calendar.current.date(byAdding: .day, value: -$0, to: currentTime)! }

        case .year:
            return (0...historyPeriod.rawValue).map { Calendar.current.date(byAdding: .month, value: -$0, to: currentTime)! }

        }
    }

    enum HistoryPeriod: Int {
        case week = 7
        case month = 30
        case year = 12
    }

    struct GroupingKey: Hashable {
        let date: DateComponents
        let waterSourceType: WaterSourceType
    }

    struct WaterIntake: Swift.Identifiable {
        let date: DateComponents
        let volume: Float
        let waterSourceType: WaterSourceType
        var id: UUID = UUID()

        init(date: DateComponents, volume: Float, waterSourceType: WaterSourceType) {
            self.date = date
            self.volume = volume
            self.waterSourceType = waterSourceType
        }

        static func fromWaterConsumedList(_ waterConsumed: [WaterConsumed], _ volumeFormat: VolumeFormat) -> [WaterIntake] {
            let group = Dictionary(grouping: waterConsumed, by: { GroupingKey(date: Calendar.current.dateComponents([.year, .month, .day], from: $0.consumptionTime),  waterSourceType: $0.waterSourceType) })
            return group.map {
                WaterIntake(
                    date: $0.key.date,
                    volume: $0.value.map { volumeFormat.fromMetric($0.volume.toFloat()) }.reduce(0, +),
                    waterSourceType: $0.key.waterSourceType
                )
            }.sorted(by: { $0.volume > $1.volume })
        }
    }
}
