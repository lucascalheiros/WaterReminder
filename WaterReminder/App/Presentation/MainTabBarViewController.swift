//
//  MainTabBarViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
	private lazy var homeViewController = HomeViewController()
	private lazy var statisticsViewController = StatisticsViewController()
	private lazy var settingsViewController = SettingsViewController()
	private lazy var tabViewControllers = {
		[homeViewController, statisticsViewController, settingsViewController]
	}()
	
	func setupTabBarController() {
		tabBar.tintColor = UIColor.blue
		tabBar.backgroundColor = .clear
		setViewControllers(
			tabViewControllers,
			animated: true
		)
		modalPresentationStyle = .fullScreen
		
		if let items = tabBar.items {
			items[0].image = UIImage(systemName: "drop.fill")
			items[1].image = UIImage(systemName: "chart.bar.fill")
			items[2].image = UIImage(systemName: "gear")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBarController()
	}
}
