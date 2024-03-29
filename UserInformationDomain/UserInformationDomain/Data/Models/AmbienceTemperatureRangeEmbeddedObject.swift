//
//  AmbienceTemperatureRange.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 31/05/23.
//

import Foundation
import RealmSwift

class AmbienceTemperatureRangeEmbeddedObject: EmbeddedObject {
	@Persisted var min: Int
	@Persisted var max: Int

	convenience init(min: Int, max: Int) {
		self.init()
		self.min = min
		self.max = max
	}
}
