//
//  EditWaterSourceListVC+TableLayout.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/10/23.
//

import UIKit

extension EditWaterSourceListVC {

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch getItemForIndexPath(indexPath) {
		case .waterSourceItem:
			return 50
		case .add:
			return 40
		default:
			return 0
		}
	}
	
}
