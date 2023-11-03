//
//  CollectionExt.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import Foundation

extension Collection {
	subscript(safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
