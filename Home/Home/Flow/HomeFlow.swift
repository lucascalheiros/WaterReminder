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
import WaterManagementDomain

public class HomeFlow: Flow {

	public var root: Presentable {
		return self.rootViewController
	}

	private lazy var rootViewController = {
		let nc = UINavigationController()
		nc.setDefaultAppearance()
		return nc
	}()
	private let container: Container

	public init(container: Container) {
		self.container = container
	}

	public func navigate(to step: Step) -> FlowContributors {

		guard let step = step as? HomeFlowSteps else { return .none }

		switch step {

		case .home:
			return navigateToHome()
		case .waterSourceEditor:
			return waterSourceModal()
        case .createWaterSource:
            return createWaterSourceModel()
        case .addDrink:
            return addDrinkModal()
        case .drinkShortcut(let drink):
            return drinkShortcutModal(drink)
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
        nav.setModalAppearance()
        nav.modalPresentationStyle = .pageSheet

		if let sheet = nav.sheetPresentationController {
			sheet.detents = [.large()]
		}

        rootViewController.visibleViewController?.present(nav, animated: true, completion: nil)
		return .none
	}

    private func createWaterSourceModel() -> FlowContributors {
        let viewController = container.resolve(CreateWaterSourceItemVC.self)!
        let nav = UINavigationController(rootViewController: viewController)
        nav.setModalAppearance()
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        rootViewController.visibleViewController?.present(nav, animated: true, completion: nil)
        return .none
    }

    private func addDrinkModal() -> FlowContributors {
        let viewController = container.resolve(AddDrinkVC.self)!
        let nav = UINavigationController(rootViewController: viewController)
        nav.setModalAppearance()
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        rootViewController.visibleViewController?.present(nav, animated: true, completion: nil)
        return .none
    }

    private func drinkShortcutModal(_ drink: Drink) -> FlowContributors {
        let viewController = container.resolve(DrinkShortcutVC.self, argument: drink)!
        let nav = UINavigationController(rootViewController: viewController)
        nav.setModalAppearance(titleColor: drink.color)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        rootViewController.visibleViewController?.present(nav, animated: true, completion: nil)
        return .none
    }
}
