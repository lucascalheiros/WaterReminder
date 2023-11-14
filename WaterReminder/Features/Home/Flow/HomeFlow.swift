//
//  HomeFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import Swinject
import Core

class HomeFlow: Flow {

	var root: Presentable {
		return self.rootViewController
	}

	private lazy var rootViewController = {
		let nc = UINavigationController()
		nc.setDefaultAppearance()
		return nc
	}()
	private let container: Container

	init(container: Container) {
		self.container = container
	}

	func navigate(to step: Step) -> FlowContributors {

		guard let step = step as? HomeFlowSteps else { return .none }

		switch step {

		case .home:
			return navigateToHome()
		case .waterSourceEditor:
			return waterSourceModal()
		}
	}

	private func navigateToHome() -> FlowContributors {
		let viewController = container.resolve(HomeVC.self)!
        viewController.navigationItem.title = String(localized: "home.screenTitle")
		rootViewController.pushViewController(viewController, animated: false)
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: container.resolve(HomeFlowStepper.self)!))
	}

	private func waterSourceModal() -> FlowContributors {
		let viewController = container.resolve(EditWaterSourceListVC.self)!
		let nav = UINavigationController(rootViewController: viewController)
		nav.modalPresentationStyle = .pageSheet

		if let sheet = nav.sheetPresentationController {
			sheet.detents = [.large()]
		}

		rootViewController.present(nav, animated: true, completion: nil)
		return .none
	}
}
