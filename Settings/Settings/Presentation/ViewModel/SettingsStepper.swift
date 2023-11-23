//
//  SettingsStepper.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import RxFlow
import RxRelay

class SettingsStepper: Stepper {
	let steps: RxRelay.PublishRelay<RxFlow.Step> = PublishRelay()

	var initialStep: Step {
		get {
			return SettingsFlowSteps.settings
		}
	}
}
