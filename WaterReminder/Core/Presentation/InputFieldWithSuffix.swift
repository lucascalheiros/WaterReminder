//
//  InputFieldWithSuffix.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/05/23.
//

import Foundation
import UIKit

class InputFieldWithSuffix: UITextField, UITextFieldDelegate {

	private let bottomLine = CALayer()

	override var text: String? {
		get {
			super.text
		}
		set {
			super.text = newValue
			textPhantom.text = newValue
		}
	}

    override var font: UIFont? {
        didSet {
            textPhantom.font = font
        }
    }

	private func setupUnderlineLayer() {
		var frame = self.bounds
		frame.origin.y = frame.size.height - 1
		frame.size.height = 1
		bottomLine.frame = frame
		bottomLine.backgroundColor = UIColor.white.cgColor
	}

	private lazy var textPhantom = {
		let label = UILabel()
		label.textColor = .clear
		return label
	}()

	lazy var suffix = {
		let label = UILabel()
        label.font = .h4
		label.textColor = .white.withAlphaComponent(0.7)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		prepareConfiguration()
		prepareConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func prepareConfiguration() {
		delegate = self
		borderStyle = .none
		textAlignment = .center
        font = .h3
		textColor = .white
		keyboardType = .decimalPad
		borderStyle = .none
		layer.addSublayer(bottomLine)
		layer.masksToBounds = true
	}

	func prepareConstraints() {
		addConstrainedSubviews(textPhantom, suffix)
		NSLayoutConstraint.activate([
			textPhantom.centerXAnchor.constraint(equalTo: centerXAnchor),
			textPhantom.centerYAnchor.constraint(equalTo: centerYAnchor),
			suffix.leadingAnchor.constraint(equalTo: textPhantom.trailingAnchor, constant: 2),
			suffix.centerYAnchor.constraint(equalTo: textPhantom.centerYAnchor)
		])
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		let allowedCharacters = CharacterSet(charactersIn: ".,").union(CharacterSet.decimalDigits)
		let characterSet = CharacterSet(charactersIn: string)
		let currentString = (textField.text ?? "") as NSString
		let newString = currentString.replacingCharacters(in: range, with: string)
		if allowedCharacters.isSuperset(of: characterSet) && newString.count <= 7 {
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
