//
//  RootViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

class RootViewController: UINavigationController {
	
	var isPushingViewController = false

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}


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
