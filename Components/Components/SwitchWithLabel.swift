//
//  SwitchWithLabel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxSwift
import RxCocoa
import Common

open class SwitchWithLabel: ProgrammaticView {

	open lazy var switchView = {
		let uiSwitch = UISwitch()
        uiSwitch.onTintColor = DefaultComponentsTheme.current.primary.color
		return uiSwitch
	}()

	open lazy var label = {
		let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
        label.textColor = DefaultComponentsTheme.current.background.onColor
		return label
	}()

	open override func prepareConstraints() {
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
