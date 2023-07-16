//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

class UserInformationObject: BaseObject {
    typealias DomainType = UserInformation

    @Persisted var weightInGrams: Int?
    @Persisted var activityLevelInWeekDays: Int?
    @Persisted var ambienceTemperatureLevel: AmbienceTemperatureRangeEmbeddedObject?
    @Persisted var date: Date = Date()

    convenience init(
        userInformation: UserInformation
    ) {
        self.init()
        self.id = userInformation.id
        self.weightInGrams = userInformation.weightInGrams
        self.activityLevelInWeekDays = userInformation.activityLevelInWeekDays
		self.ambienceTemperatureLevel = userInformation.ambienceTemperatureLevel.run {
			AmbienceTemperatureRangeEmbeddedObject(
				min: $0.range.lowerBound,
				max: $0.range.upperBound
			)
		}

        self.date = userInformation.date
    }

    func toDomainModel() -> UserInformation {
        return UserInformation(
			id: id,
			weightInGrams: weightInGrams,
			activityLevelInWeekDays: activityLevelInWeekDays,
			ambienceTemperatureLevel: ambienceTemperatureLevel.run {
				let mean = $0.min + $0.max / 2
				return AmbienceTemperatureLevel.allCases.first(where: { level in
					level.range.contains(mean)
				}) ?? .moderate
			},
			date: date
		)
    }
}

extension UserInformation {
    func toDataObject() -> UserInformationObject {
        UserInformationObject(userInformation: self)
    }
}
