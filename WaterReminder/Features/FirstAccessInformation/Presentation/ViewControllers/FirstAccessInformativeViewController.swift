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
		label.text = "If you already know your expected daily water consumption or don't want to provide the information please press skip estimatimative below."
		label.font = UIFont.boldSystemFont(ofSize: 16.0)
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
		
		informativeMainText.text = "We will ask you some questions in order to estimate your expected daily water consumption."

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
