//
//  HomeFlowSteps.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import RxFlow
import WaterManagementDomain

public enum HomeFlowSteps: Step {
	case home
	case waterSourceEditor
    case createWaterSource
    case addDrink
    case drinkShortcut(Drink)
}
