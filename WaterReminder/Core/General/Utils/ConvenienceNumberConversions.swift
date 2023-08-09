//
//  ConvenienceNumberConversions.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation

extension Int {
	func toDouble() -> Double {
		Double(self)
	}

	func toString() -> String {
		String(self)
	}
}

extension Double {
	func toInt() -> Int {
		Int(self)
	}

	func toString() -> String {
		String(self)
	}
}

extension String {
	func toInt() -> Int? {
		Int(self)
	}

	func toFloat() -> Float? {
		Float(self)
	}
}
