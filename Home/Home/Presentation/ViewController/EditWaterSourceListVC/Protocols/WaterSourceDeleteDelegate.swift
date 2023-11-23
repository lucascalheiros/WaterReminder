//
//  WaterSourceDeleteDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import Foundation
import WaterManagementDomain

protocol WaterSourceDeleteDelegate {
    func onDeleteWaterSource(_ waterSource: WaterSource)
}
