//
//  RootViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

class RootViewController: UINavigationController {
	
	init() {
		super.init(rootViewController: FirstAccessInformationViewController())
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var isPushingViewController = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
		interactivePopGestureRecognizer?.delegate = self
	}
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		isPushingViewController = true
		super.pushViewController(viewController, animated: animated)
	}
}

extension RootViewController: UIGestureRecognizerDelegate {
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
		return viewControllers.count > 1 && !isPushingViewController
	}
}

extension RootViewController: UINavigationControllerDelegate {
	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		isPushingViewController = false
	}
}
