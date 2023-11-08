//
//  FirstAccessInformative.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import UIKit

class FirstAccessInformativeViewController: BaseChildPageController {
	
	lazy var informativeSecondaryText = {
		let label = UILabel()
		label.text = String(localized: "welcome.informativeText")
        label.font = .body
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(label)
		return label
	}()

	lazy var containerView: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		containerView.addSubview(informativeMainText)
		view.addSubview(containerView)
		
		informativeMainText.text = String(localized: "welcome.mainText")

		NSLayoutConstraint.activate([
			containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			informativeMainText.widthAnchor.constraint(equalTo: containerView.widthAnchor),
			informativeMainText.topAnchor.constraint(equalTo: containerView.topAnchor),
			informativeSecondaryText.topAnchor.constraint(equalTo: informativeMainText.bottomAnchor, constant: 16),
			informativeSecondaryText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			informativeSecondaryText.widthAnchor.constraint(equalTo: containerView.widthAnchor)
		])
	}
}
