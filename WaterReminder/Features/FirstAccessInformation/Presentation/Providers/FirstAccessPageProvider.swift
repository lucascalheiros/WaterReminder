//
//  FirstAccessPageProvider.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class FirstAccessPageProvider: PageProviderProtocol {
	lazy var firstAccessInformative = {
		let controller = FirstAccessInformative()
		controller.parentPageProvider = self.parentPageProvider
		return controller
	}()
	lazy var weightInputViewController = {
		let controller = WeightInputViewController()
		controller.parentPageProvider = self.parentPageProvider
		return controller
	}()
	lazy var activityLevelInputViewController = {
		let controller = ActivityLevelInputViewController()
		controller.parentPageProvider = self.parentPageProvider
		return controller
	}()
	lazy var ambienceTemperatureInputViewController = {
		let controller = AmbienceTemperatureInputViewController()
		controller.parentPageProvider = self.parentPageProvider
		return controller
	}()
	lazy var confirmationDailyConsumptionViewController = {
		let controller = ConfirmationDailyConsumptionViewController()
		controller.parentPageProvider = self.parentPageProvider
		return controller
	}()
	
	let count = 5
	
	let parentPageProvider: (ParentPageControllerProtocol & UIPageViewController)
	
	internal init(parentPageProvider: (UIPageViewController & ParentPageControllerProtocol)) {
		self.parentPageProvider = parentPageProvider
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
		case is FirstAccessInformative:
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
