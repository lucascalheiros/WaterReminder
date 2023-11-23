//
//  FirstAccessInformationStepper.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 11/06/23.
//

import RxRelay
import RxFlow
import Core

public class FirstAccessInformationStepper: Stepper {
    public let steps: RxRelay.PublishRelay<RxFlow.Step> = PublishRelay()

    public var initialStep: Step {
		get {
			return FirstAccessFlowSteps.firstAccessUserInformationIsRequired
		}
	}
}

