//
//  FirstAccessInformationStepper.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 11/06/23.
//

import RxRelay
import RxFlow

internal class FirstAccessInformationStepper: Stepper {
	let steps: RxRelay.PublishRelay<RxFlow.Step> = PublishRelay()

	var initialStep: Step {
		get {
			return FirstAccessFlowSteps.firstAccessUserInformationIsRequired
		}
	}
}

