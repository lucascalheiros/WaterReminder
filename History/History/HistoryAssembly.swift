//
//  HistoryAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

public class HistoryAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
		container.autoregister(
			HistoryVC.self,
            initializer: HistoryVC.newInstance
		)
		container.autoregister(
			HistoryViewModel.self,
			initializer: HistoryViewModel.init
		)
	}
}
