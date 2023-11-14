//
//  MainAppFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import UIKit
import RxFlow
import Swinject
import Core

class MainAppFlow: Flow {
	var root: Presentable {
		return self.rootViewController
	}
	
	private lazy var rootViewController = tabBarVC()
	private let container: Container
	
	init(container: Container) {
		self.container = container
	}
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step as? MainAppFlowSteps else { return .none }
		
		switch step {
			
		case .mainApp:
			return navigateToMainAppTab()
		}
	}

	private func tabBarVC() -> UITabBarController {
		let vc = UITabBarController()
		vc.tabBar.standardAppearance = tabBarAppearance()
		vc.view.backgroundColor = .systemTeal
		return vc
	}

	private func tabBarItemAppearance() -> UITabBarItemAppearance {
		let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = AppColorGroup.primary.color.withAlphaComponent(0.3)
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColorGroup.primary.color.withAlphaComponent(0.3)]
		itemAppearance.selected.iconColor = AppColorGroup.primary.color
		itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColorGroup.primary.color]
		return itemAppearance
	}

	private func tabBarAppearance() -> UITabBarAppearance {
		let itemAppearance = tabBarItemAppearance()
		let appearance = UITabBarAppearance()
		appearance.inlineLayoutAppearance = itemAppearance
		appearance.stackedLayoutAppearance = itemAppearance
		appearance.compactInlineLayoutAppearance = itemAppearance
		appearance.backgroundColor = AppColorGroup.background.color
		return appearance
	}
	
	private func navigateToMainAppTab() -> FlowContributors {
		let homeFlow = HomeFlow(container: self.container)
		let statisticsFlow = StatisticsFlow(container: self.container)
		let settingsFlow = SettingsFlow(container: self.container)
		
		Flows.use(homeFlow, statisticsFlow, settingsFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
			rootViewController.setViewControllers([root1, root2, root3], animated: true)
			rootViewController.navigationController?.setNavigationBarHidden(true, animated: false)
			
			if let items = rootViewController.tabBar.items {
				items[0].image = UIImage(systemName: "drop.fill")
				items[1].image = UIImage(systemName: "chart.bar.fill")
				items[2].image = UIImage(systemName: "gear")
			}
		}
		
		return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow,
														withNextStepper: OneStepper(withSingleStep:  HomeFlowSteps.home)),
											.contribute(withNextPresentable: statisticsFlow,
														withNextStepper: OneStepper(withSingleStep:  StatisticsFlowSteps.statistics)),
											.contribute(withNextPresentable: settingsFlow,
														withNextStepper: OneStepper(withSingleStep:  SettingsFlowSteps.settings))])
	}
	
}
