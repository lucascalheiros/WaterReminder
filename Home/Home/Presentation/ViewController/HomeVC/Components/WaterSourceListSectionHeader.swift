//
//  WaterSourceListSectionHeader.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/08/23.
//

import UIKit
import Core
import Common

class WaterSourceListSectionHeader: ProgrammaticView {

	private lazy var editBtn: UIButton = {
		let button = UIButton(type: .custom)
		button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
		button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
		button.tintColor = AppColorGroup.primary.color
		return button
	}()

	var clickListener: (() -> Void)?

	override init(frame: CGRect) {
		super.init(frame: frame)

		addConstrainedSubviews(editBtn)

		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClick))
		editBtn.addGestureRecognizer(tap)

		NSLayoutConstraint.activate([
			editBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			editBtn.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			editBtn.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	@objc func onClick() {
		if let clickListener {
			clickListener()
		}
	}
}
