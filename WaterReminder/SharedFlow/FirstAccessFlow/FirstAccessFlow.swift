//
//  FirstAccessFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import Swinject

class FirstAccessFlow: Flow {

	var root: Presentable {
		return self.rootViewController
	}

	private let rootViewController = UINavigationController()
	private let container: Container

	init(container: Container) {
		self.container = container
	}

	func navigate(to step: Step) -> FlowContributors {

		guard let step = step as? FirstAccessFlowSteps else { return .none }

		switch step {

		case .firstAccessUserInformationIsRequired:
			return navigateToFirstAccessTutorial()
		case .firstAccessUserInformationAlreadyProvided:
			return navigateToHome()
		}
	}

	private func navigateToFirstAccessTutorial() -> FlowContributors {
		let viewController = container.resolve(FirstAccessPageViewController.self)!
		self.rootViewController.pushViewController(viewController, animated: false)
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: container.resolve(FirstAccessInformationStepper.self)!))
	}

	private func navigateToHome() -> FlowContributors {
		let mainAppFlow = MainAppFlow(container: self.container)

		Flows.use(mainAppFlow, when: .created) { [unowned self] root in
			self.rootViewController.pushViewController(root, animated: false)
		}

		return .one(flowContributor: .contribute(withNextPresentable: mainAppFlow, withNextStepper: OneStepper(withSingleStep: MainAppFlowSteps.mainApp)))
	}
}
