//
//  FirstAccessFlowSteps.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import RxFlow

public enum FirstAccessFlowSteps: Step {
    case entryPoint
	case firstAccessUserInformationIsRequired
	case firstAccessUserInformationAlreadyProvided
}
