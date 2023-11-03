//
//  HomeFlowStepper.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/10/23.
//

import RxRelay
import RxFlow

internal class HomeFlowStepper: Stepper {
	let steps: RxRelay.PublishRelay<RxFlow.Step> = PublishRelay()

	var initialStep: Step {
		get {
			return HomeFlowSteps.home
		}
	}

	func showWaterSourceModal() {
		steps.accept(HomeFlowSteps.waterSourceEditor)
	}
}

