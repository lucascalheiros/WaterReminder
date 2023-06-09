//
//  HideKeyboardWhenTappedOut.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit

extension UIViewController {
	func prepareHideKeyboardWhenTappedOut() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
