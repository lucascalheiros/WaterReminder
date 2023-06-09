//
//  FirstAccessPageProvider.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class FirstAccessPageProvider: PageProviderProtocol {
	let firstAccessInformative: FirstAccessInformativeViewController
	let weightInputViewController: WeightInputViewController
	let activityLevelInputViewController: ActivityLevelInputViewController
	let ambienceTemperatureInputViewController: AmbienceTemperatureInputViewController
	let confirmationDailyConsumptionViewController: ConfirmationDailyConsumptionViewController
	let count = 5

	internal init(firstAccessInformative: FirstAccessInformativeViewController, weightInputViewController: WeightInputViewController, activityLevelInputViewController: ActivityLevelInputViewController, ambienceTemperatureInputViewController: AmbienceTemperatureInputViewController, confirmationDailyConsumptionViewController: ConfirmationDailyConsumptionViewController) {
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
		case is FirstAccessInformativeViewController:
			return 0
		case is WeightInputViewController:
			return 1
		case is ActivityLevelInputViewController:
			return 2
		case is AmbienceTemperatureInputViewController:
			return 3
		case is ConfirmationDailyConsumptionViewController:
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
