//
//  HistoryAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

class HistoryAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			HistoryViewController.self
		) {
			return HistoryViewController(historyViewModel: container.resolve(HistoryViewModel.self)!)
		}
		container.autoregister(
			HistoryViewModel.self,
			initializer: HistoryViewModel.init
		)
	}
}
