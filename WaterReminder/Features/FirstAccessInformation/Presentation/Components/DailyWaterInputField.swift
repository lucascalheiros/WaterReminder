//
//  DailyWaterInputField.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/05/23.
//

import Foundation
import UIKit

class DailyWaterInputField: UITextField, UITextFieldDelegate {

	let bottomLine = CALayer()

	func setupUnderlineLayer() {
		var frame = self.bounds
		frame.origin.y = frame.size.height - 1
		frame.size.height = 1

		bottomLine.frame = frame
		bottomLine.backgroundColor = UIColor.white.cgColor
	}

	private lazy var textPhantom = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 26)
		label.textColor = .clear
		return label
	}()

	private lazy var suffix = {
		let label = UILabel()
		label.text = "ml"
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = .white.withAlphaComponent(0.7)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		delegate = self
		borderStyle = .none
		textAlignment = .center
		font = UIFont.boldSystemFont(ofSize: 26)
		textColor = .white
		keyboardType = .numberPad
		borderStyle = .none
		layer.addSublayer(bottomLine)
		layer.masksToBounds = true

		addConstrainedSubviews(textPhantom, suffix)
		NSLayoutConstraint.activate([
			textPhantom.centerXAnchor.constraint(equalTo: centerXAnchor),
			textPhantom.centerYAnchor.constraint(equalTo: centerYAnchor),

			suffix.leadingAnchor.constraint(equalTo: textPhantom.trailingAnchor, constant: 2),
			suffix.centerYAnchor.constraint(equalTo: textPhantom.centerYAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		let allowedCharacters = CharacterSet.decimalDigits
		let characterSet = CharacterSet(charactersIn: string)
		let currentString = (textField.text ?? "") as NSString
		let newString = currentString.replacingCharacters(in: range, with: string)
		if allowedCharacters.isSuperset(of: characterSet) && newString.count <= 5 {
			textPhantom.text = newString
			return true
		}
		return false
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		setupUnderlineLayer()
	}

}
