//
//  StatisticsAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

class StatisticsAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			StatisticsViewController.self
		) {
			return StatisticsViewController()
		}
	}
}

