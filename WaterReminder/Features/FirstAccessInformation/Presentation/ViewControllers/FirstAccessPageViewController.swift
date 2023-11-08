//
//  FirstAccessInformationViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit
import RxSwift

class FirstAccessPageViewController: UIPageViewController {
	let pageProvider: PageProviderProtocol
	let firstAccessInformationViewModel: FirstAccessInformationSharedViewModel

	private lazy var nextButton = {
		let button = UIButton()
		button.setTitle(String(localized: "generic.next"), for: .normal)
        button.titleLabel?.font = .buttonDefault
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextClick)))
		return button
	}()
	
	private lazy var previousButton = {
		let button = UIButton()
		button.setTitle(String(localized: "generic.previous"), for: .normal)
		button.titleLabel?.font = .buttonDefault
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(previousClick)))
		return button
	}()

	let disposeBag = DisposeBag()
	
	init(
		pageProvider: PageProviderProtocol,
		firstAccessInformationViewModel: FirstAccessInformationSharedViewModel
	) {
		self.pageProvider = pageProvider
		self.firstAccessInformationViewModel = firstAccessInformationViewModel
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupPageController()

		firstAccessInformationViewModel.pageNavigationDelegate.setTotalPages(total: pageProvider.count)
		firstAccessInformationViewModel.pageNavigationDelegate.currentPageIndex.subscribe {
			let currentIndex = self.presentationIndex(for: self)
			if let controller = self.pageProvider.instanceFor(index: $0) {
				self.setViewControllers(
					[controller],
					direction: (currentIndex < $0) ? .forward : .reverse,
					animated: true
				)
			}
		}.disposed(by: disposeBag)

		firstAccessInformationViewModel.pageNavigationDelegate.isFirstPage.subscribe {
			self.previousButton.isHidden = $0
		}.disposed(by: disposeBag)

		firstAccessInformationViewModel.pageNavigationDelegate.isLastPage.subscribe {
			self.nextButton.isHidden = $0
		}.disposed(by: disposeBag)

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

	private func setupPageController() {
		dataSource = self
		delegate = self
		view.backgroundColor = .systemTeal
		view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
		setViewControllers([pageProvider.instanceFor(index: 0)!], direction: .forward, animated: true,
						   completion: nil)
		didMove(toParent: self)
	}

	func pageViewController(
		_ pageViewController: UIPageViewController,
		didFinishAnimating finished: Bool,
		previousViewControllers: [UIViewController],
		transitionCompleted completed: Bool
	) {
		if completed {
			let currentIndex = presentationIndex(for: self)
			firstAccessInformationViewModel.pageNavigationDelegate.setPage(page: currentIndex)
		}

	}

	@objc func nextClick() {
		let currentIndex = presentationIndex(for: self)
		firstAccessInformationViewModel.pageNavigationDelegate.setPage(page: currentIndex + 1)
	}
	
	@objc func previousClick() {
		let currentIndex = presentationIndex(for: self)
		firstAccessInformationViewModel.pageNavigationDelegate.setPage(page: currentIndex - 1)
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

extension FirstAccessPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
