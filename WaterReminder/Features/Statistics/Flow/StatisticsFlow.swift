//
//  StatisticsFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import Swinject

class StatisticsFlow: Flow {

	var root: Presentable {
		return self.rootViewController
	}

	private let rootViewController = UINavigationController()
	private let container: Container

	init(container: Container) {
		self.container = container
	}

	func navigate(to step: Step) -> FlowContributors {

		guard let step = step as? StatisticsFlowSteps else { return .none }

		switch step {

		case .statistics:
			return navigateToStatistics()
		}
	}

	private func navigateToStatistics() -> FlowContributors {
		let viewController = container.resolve(StatisticsViewController.self)!
		self.rootViewController.pushViewController(viewController, animated: false)
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: OneStepper(withSingleStep: StatisticsFlowSteps.statistics)))
	}

}