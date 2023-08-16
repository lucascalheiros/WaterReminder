//
//  MainAppFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import UIKit
import RxFlow
import Swinject

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
		itemAppearance.normal.iconColor = Theme.primaryDisabled.mainColor
		itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.primaryDisabled.mainColor]
		itemAppearance.selected.iconColor = Theme.primary.mainColor
		itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.primary.mainColor]
		return itemAppearance
	}

	private func tabBarAppearance() -> UITabBarAppearance {
		let itemAppearance = tabBarItemAppearance()
		let appearance = UITabBarAppearance()
		appearance.inlineLayoutAppearance = itemAppearance
		appearance.stackedLayoutAppearance = itemAppearance
		appearance.compactInlineLayoutAppearance = itemAppearance
		appearance.backgroundColor = Theme.primaryBackground.mainColor
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
