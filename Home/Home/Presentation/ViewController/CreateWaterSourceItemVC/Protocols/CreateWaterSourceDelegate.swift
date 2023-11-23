//
//  CreateWaterSourceProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import Foundation
import WaterManagementDomain

protocol CreateWaterSourceDelegate {
    func onCreateWaterSource(_ volume: Int, _ type: WaterSourceType)
}
