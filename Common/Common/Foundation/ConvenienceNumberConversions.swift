//
//  ConvenienceNumberConversions.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation

public extension Int {
	func toDouble() -> Double {
		Double(self)
	}

    func toFloat() -> Float {
        Float(self)
    }

	func toString() -> String {
		String(self)
	}
}

public extension Double {
	func toInt() -> Int {
		Int(self)
	}

	func toString() -> String {
		String(self)
	}
}

public extension String {
	func toInt() -> Int? {
		Int(self)
	}

	func toFloat() -> Float? {
		Float(self)
	}
}
