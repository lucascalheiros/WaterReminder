//
//  AddDrinkVC+SelectHandlers.swift
//  Home
//
//  Created by Lucas Calheiros on 22/02/25.
//

import UIKit

extension AddDrinkVC {
    func presentNamePicker() {
        let alert = UIAlertController(
            title: String(localized: "Drink name"),
            message: String(localized: "Please input the name of the drink") ,
            preferredStyle: .alert
        )
        alert.addTextField { (textField) in
            textField.keyboardType = .alphabet
            textField.text = ""
            textField.textAlignment = .center
        }
        alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: {[weak self] _ in
            self?.addDrinkViewModel.setName(alert.textFields?.first?.text ?? "")
        }))
        alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
        present(alert, animated: true, completion: nil)
    }

    func presentColorPicker(forDark isDark: Bool) {
        delegate.onColorSelected = { [weak self] color in
            if isDark {
                self?.addDrinkViewModel.setDarkColor(color)
            } else {
                self?.addDrinkViewModel.setLightColor(color)
            }
        }
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Background Color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = delegate
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        self.present(colorPicker, animated: true)
    }
}

class ColorPickerDelegate: NSObject, UIColorPickerViewControllerDelegate {

    var onColorSelected: ((UIColor) -> Void)?

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if !continuously {
            onColorSelected?(color)
        }
    }
}
