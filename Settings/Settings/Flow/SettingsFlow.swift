//
//  SettingsFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import Swinject
import Core

public class SettingsFlow: Flow {

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

		guard let step = step as? SettingsFlowSteps else { return .none }

		switch step {

		case .settings:
			return navigateToSettings()

        case .manageNotifications:
            return presentManageNotifications()

        case .addFixedNotification:
            return presentAddFixedNotification()
        }
	}

	private func navigateToSettings() -> FlowContributors {
		let viewController = container.resolve(SettingsVC.self)!
        viewController.navigationItem.title = String(localized: "settings.screenTitle")
		rootViewController.pushViewController(viewController, animated: false)
		return .one(
			flowContributor: .contribute(
				withNextPresentable: viewController,
				withNextStepper: container.resolve(SettingsStepper.self)!
			)
		)
	}

    private func presentManageNotifications() -> FlowContributors {
        let viewController = container.resolve(ManageNotificationsVC.self)!
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .pageSheet
        nav.setModalAppearance()

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
        }

        rootViewController.present(nav, animated: true, completion: nil)

        return .none
    }

    private func presentAddFixedNotification() -> FlowContributors {
        let viewController = container.resolve(AddFixedNotificationVC.self)!
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .pageSheet
        nav.setModalAppearance()

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        rootViewController.visibleViewController?.present(nav, animated: true, completion: nil)

        return .none
    }

}
