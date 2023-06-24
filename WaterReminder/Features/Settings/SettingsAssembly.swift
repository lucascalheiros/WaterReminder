//
//  SettingsAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

class SettingsAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			SettingsViewController.self
		) {
			return SettingsViewController()
		}
	}
}
