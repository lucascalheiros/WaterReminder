//
//  BaseChildPageController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit
import Core
import Components

class BaseChildPageController: UIViewController {
	let firstAccessInformationViewModel: FirstAccessInformationSharedViewModel

	lazy var informativeMainText = {
		let label = UILabel()
        label.font = DefaultComponentsTheme.current.screenTitle
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
        label.textColor = DefaultComponentsTheme.current.background.onColor
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		return label
	}()
	
	init(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) {
		self.firstAccessInformationViewModel = firstAccessInformationViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func skipButtonClick() {
		firstAccessInformationViewModel.pageNavigationDelegate.skipToLastPage()
	}
}
