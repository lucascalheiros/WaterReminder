//
//  HomeAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

class HomeAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			HomeViewController.self
		) {
			let home = HomeViewController()
			home.viewModel = container.resolve(HomeViewModel.self)!
			return home
		}
		container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
	}
}
