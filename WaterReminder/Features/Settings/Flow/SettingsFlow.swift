//
//  SettingsFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import Swinject

class SettingsFlow: Flow {

	var root: Presentable {
		return self.rootViewController
	}

	private let rootViewController = UINavigationController()
	private let container: Container

	init(container: Container) {
		self.container = container
	}

	func navigate(to step: Step) -> FlowContributors {

		guard let step = step as? SettingsFlowSteps else { return .none }

		switch step {

		case .settings:
			return navigateToSettings()
		}
	}

	private func navigateToSettings() -> FlowContributors {
		let viewController = container.resolve(SettingsViewController.self)!
		self.rootViewController.pushViewController(viewController, animated: false)
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: OneStepper(withSingleStep: SettingsFlowSteps.settings)))
	}

}