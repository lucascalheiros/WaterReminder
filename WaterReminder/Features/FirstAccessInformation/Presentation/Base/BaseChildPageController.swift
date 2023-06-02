//
//  BaseChildPageController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class BaseChildPageController: UIViewController, ChildPageProtocol {
	var parentPageProvider: (ParentPageControllerProtocol & UIPageViewController)!

	lazy var informativeMainText = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		return label
	}()
	
	private lazy var skipEstimativeButton = {
		let button = UIButton()
		button.setTitle("Skip estimative", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipButtonClick)))
		if parentPageProvider.getProvider().lastPage() == self {
			button.isHidden = true
		}
		return button
	}()
	
	override func viewDidLoad() {
		NSLayoutConstraint.activate([
			skipEstimativeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			skipEstimativeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	@objc func skipButtonClick() {
		parentPageProvider.setViewControllers([parentPageProvider.getProvider().lastPage()!], direction: .forward,
											  animated: true) { _ in
			self.parentPageProvider.onNavigation()
		}
	}
}
