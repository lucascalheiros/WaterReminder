//
//  ProgramaticView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//  Credits to Dillon McElhinney : https://dilloncodes.com/how-i-organize-layout-code-in-swift

import UIKit

class ProgrammaticView: UIView {
	@available(*, unavailable, message: "Don't use init(coder:), override init(frame:) instead")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		prepareConfiguration()
		prepareConstraints()
	}

	func prepareConfiguration() {}
	func prepareConstraints() {}
}

