//
//  SwitchWithLabel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxSwift
import RxCocoa

class SwitchWithLabel: ProgrammaticView {

	lazy var switchView = {
		let uiSwitch = UISwitch()
		uiSwitch.onTintColor = .blue
		return uiSwitch
	}()

	lazy var label = {
		let label = UILabel()
        label.font = .body
		label.textColor = .white
		return label
	}()

	override func prepareConstraints() {
		addConstrainedSubviews(label, switchView)

		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor),
			label.heightAnchor.constraint(equalTo: heightAnchor),
			label.trailingAnchor.constraint(equalTo: switchView.leadingAnchor),

			switchView.trailingAnchor.constraint(equalTo: trailingAnchor),
			switchView.heightAnchor.constraint(equalTo: heightAnchor)
		])
	}

}
