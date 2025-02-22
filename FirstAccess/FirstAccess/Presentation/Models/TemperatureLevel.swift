//
//  TemperatureLevel.swift
//  iosApp
//
//  Created by Lucas Calheiros on 02/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//


enum TemperatureLevel: CaseIterable, Identifiable {
    case cold
    case moderate
    case warm
    case hot

    var id: String {
        title
    }

    var title: String {
        switch self {

        case .cold:
            String(localized: "Cold")
        case .moderate:
            String(localized: "Moderate")
        case .warm:
            String(localized: "Warm")
        case .hot:
            String(localized: "Hot")
        }
    }

    func description(_ scale: TemperatureScale) -> String {
        return switch self {

        case .cold:
            String(
                format: "Less than %.0f°",
                20.0.convertTemperature(from: .celsius, to: scale)
            )
        case .moderate:
            String(
                format: "%.0f to %.0f°",
                20.0.convertTemperature(from: .celsius, to: scale),
                25.0.convertTemperature(from: .celsius, to: scale)
            )
        case .warm:
            String(
                format: "%.0f to %.0f°",
                26.0.convertTemperature(from: .celsius, to: scale),
                30.0.convertTemperature(from: .celsius, to: scale)
            )
        case .hot:
            String(
                format: "More than %.0f°",
                30.0.convertTemperature(from: .celsius, to: scale)
            )
        }
    }

}

extension Double {
    func convertTemperature(from currentScale: TemperatureScale, to targetScale: TemperatureScale) -> Double {
        switch (currentScale, targetScale) {
        case (.celsius, .fahrenheit):
            return (self * 9 / 5) + 32
        case (.fahrenheit, .celsius):
            return (self - 32) * 5 / 9
        default:
            return self
        }
    }
}
