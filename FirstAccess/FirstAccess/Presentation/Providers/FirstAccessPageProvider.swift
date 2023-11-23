//
//  FirstAccessPageProvider.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class FirstAccessPageProvider: PageProviderProtocol {
	let firstAccessInformative: FirstAccessInformativeVC
	let weightInputViewController: WeightInputVC
	let activityLevelInputViewController: ActivityLevelInputVC
	let ambienceTemperatureInputViewController: AmbienceTemperatureInputVC
	let confirmationDailyConsumptionViewController: ConfirmationDailyConsumptionVC
	let count = 5

	internal init(firstAccessInformative: FirstAccessInformativeVC, weightInputViewController: WeightInputVC, activityLevelInputViewController: ActivityLevelInputVC, ambienceTemperatureInputViewController: AmbienceTemperatureInputVC, confirmationDailyConsumptionViewController: ConfirmationDailyConsumptionVC) {
		self.firstAccessInformative = firstAccessInformative
		self.weightInputViewController = weightInputViewController
		self.activityLevelInputViewController = activityLevelInputViewController
		self.ambienceTemperatureInputViewController = ambienceTemperatureInputViewController
		self.confirmationDailyConsumptionViewController = confirmationDailyConsumptionViewController
	}
	
	func instanceFor(index: Int) -> UIViewController? {
		switch index {
		case 0:
			return self.firstAccessInformative
		case 1:
			return self.weightInputViewController
		case 2:
			return self.activityLevelInputViewController
		case 3:
			return self.ambienceTemperatureInputViewController
		case 4:
			return self.confirmationDailyConsumptionViewController
		default:
			return nil
		}
	}
	
	func indexFor(viewController: UIViewController) -> Int? {
		switch viewController {
		case is FirstAccessInformativeVC:
			return 0
		case is WeightInputVC:
			return 1
		case is ActivityLevelInputVC:
			return 2
		case is AmbienceTemperatureInputVC:
			return 3
		case is ConfirmationDailyConsumptionVC:
			return 4
		default:
			return nil
		}
	}
	
	func firstPage() -> UIViewController? {
		instanceFor(index: 0)
	}
	
	func lastPage() -> UIViewController? {
		instanceFor(index: count - 1)
	}
}
