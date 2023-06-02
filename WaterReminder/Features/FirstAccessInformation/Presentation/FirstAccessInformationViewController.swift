//
//  FirstAccessInformationViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class FirstAccessInformationViewController: UIPageViewController, ParentPageControllerProtocol {
	lazy var pageProvider = { FirstAccessPageProvider(parentPageProvider: self) }()
	
	private lazy var nextButton = {
		let button = UIButton()
		button.setTitle("Next", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextClick)))
		return button
	}()
	
	private lazy var previousButton = {
		let button = UIButton()
		button.setTitle("Previous", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(previousClick)))
		return button
	}()
	
	init() {
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupPageController()
		
		updateButtonsVisibilityBasedOnPage()

		NSLayoutConstraint.activate([
			nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			previousButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
		])
	}
	
	func getProvider() -> PageProviderProtocol {
		return pageProvider
	}

	func onNavigation() {
		updateButtonsVisibilityBasedOnPage()
	}

	private func setupPageController() {
		dataSource = self
		delegate = self
		view.backgroundColor = .systemTeal
		view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
		setViewControllers([pageProvider.instanceFor(index: 0)!], direction: .forward, animated: true,
						   completion: nil)
		didMove(toParent: self)
	}
	
	@objc func nextClick() {
		let currentIndex = presentationIndex(for: self)
		if let controller = pageProvider.instanceFor(index: currentIndex + 1) {
			setViewControllers([controller], direction: .forward, animated: true) {_ in
				self.updateButtonsVisibilityBasedOnPage()
			}
		}
	}
	
	@objc func previousClick() {
		let currentIndex = presentationIndex(for: self)
		if let controller = pageProvider.instanceFor(index: currentIndex - 1) {
			setViewControllers([controller], direction: .reverse, animated: true) {_ in
				self.updateButtonsVisibilityBasedOnPage()
			}
		}
	}
	
	func pageViewController(
		_ pageViewController: UIPageViewController,
		didFinishAnimating finished: Bool,
		previousViewControllers: [UIViewController],
		transitionCompleted completed: Bool
	) {
		updateButtonsVisibilityBasedOnPage()
	}
	
	func updateButtonsVisibilityBasedOnPage() {
		previousButton.isHidden = !hasPreviousPage()
		nextButton.isHidden = !hasNextPage()
	}
	
	func hasPreviousPage() -> Bool {
		let currentIndex = presentationIndex(for: self)
		return pageProvider.instanceFor(index: currentIndex - 1) != nil
	}
	
	func hasNextPage() -> Bool {
		let currentIndex = presentationIndex(for: self)
		return pageProvider.instanceFor(index: currentIndex + 1) != nil
	}
}

extension FirstAccessInformationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerBefore viewController: UIViewController
	) -> UIViewController? {
		if let index = pageProvider.indexFor(viewController: viewController) {
			return pageProvider.instanceFor(index: index - 1)
		}
		return nil
	}
	func pageViewController(
		_ pageViewController: UIPageViewController,
		viewControllerAfter viewController: UIViewController
	) -> UIViewController? {
		if let index = pageProvider.indexFor(viewController: viewController) {
			return pageProvider.instanceFor(index: index + 1)
		}
		return nil
	}
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return self.pageProvider.count
	}
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		if let currentVC = self.viewControllers?.first {
			return pageProvider.indexFor(viewController: currentVC)!
		} else {
			return 0
		}
	}
}
