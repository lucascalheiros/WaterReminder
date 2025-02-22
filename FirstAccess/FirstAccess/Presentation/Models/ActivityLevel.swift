//
//  ActivityLevel.swift
//  iosApp
//
//  Created by Lucas Calheiros on 02/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import UserInformationDomain

extension ActivityLevel {

    var title: String {
        switch self {

        case .none:
            String(localized: "Sedentary")
        case .light:
            String(localized: "Lightly Active")
        case .moderate:
            String(localized: "Moderately Active")
        case .heavy:
            String(localized: "Heavily Active")
        }
    }

    var description: String {
        switch self {

        case .none:
            String(localized: "Less than 30 minutes of intentional physical activity per week.")
        case .light:
            String(localized: "Less than 30 minutes of light activity per day.")
        case .moderate:
            String(localized: "Approximately 30 to 60 minutes per day of moderate-intensity activities.")
        case .heavy:
            String(localized: "At least 20 to 30 minutes per day of vigorous-intensity activities.")
        }
    }
}
