//
//  BaseChildPageController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class BaseChildPageController: UIViewController {
	let firstAccessInformationViewModel: FirstAccessInformationSharedViewModel

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
	
	lazy var skipEstimativeButton = {
		let button = UIButton()
		button.setTitle("Skip estimative", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipButtonClick)))
		return button
	}()

	init(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) {
		self.firstAccessInformationViewModel = firstAccessInformationViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		NSLayoutConstraint.activate([
			skipEstimativeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			skipEstimativeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	@objc func skipButtonClick() {
		firstAccessInformationViewModel.skipToLastPage()
	}
}
