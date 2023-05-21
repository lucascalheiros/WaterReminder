//
//  RootViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

class RootViewController: UIViewController {
    
    lazy var homeViewController = UINavigationController(rootViewController: HomeViewController())
    lazy var statisticsViewController = UINavigationController(rootViewController: StatisticsViewController())
    lazy var settingsViewController = UINavigationController(rootViewController: SettingsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarController = UITabBarController()
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.tabBar.tintColor = UIColor.blue
        tabBarController.tabBar.backgroundColor = .clear
        tabBarController.setViewControllers([homeViewController, statisticsViewController, settingsViewController], animated: true)
        tabBarController.modalPresentationStyle = .fullScreen
        
        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(systemName: "drop.fill")
            items[1].image = UIImage(systemName: "chart.bar.fill")
            items[2].image = UIImage(systemName: "gear")
        }
    }
    
}
