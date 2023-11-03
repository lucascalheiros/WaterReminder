//
//  WaterSourceListSectionHeader.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/08/23.
//

import UIKit

class WaterSourceListSectionHeader: UICollectionReusableView {

	private lazy var editBtn: UIButton = {
		let button = UIButton(type: .custom)
		button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
		button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
		button.tintColor = Theme.primary.mainColor
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

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func onClick() {
		if let clickListener {
			clickListener()
		}
	}
}
