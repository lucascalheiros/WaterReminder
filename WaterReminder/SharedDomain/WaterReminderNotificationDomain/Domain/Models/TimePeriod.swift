//
//  TimePeriod.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation

struct TimePeriod: Comparable, Codable {
	let hour: Int
	let minute: Int
	let second: Int

	init(hour: Int, minute: Int = 0, second: Int = 0) {
		let seconds = hour * 3600 + minute * 60 + second
		let second = seconds % 60
		let minutes = seconds / 60
		let minute = minutes % 60
		let hours = minutes / 60
		self.hour = hours
		self.minute = minute
		self.second = second
	}

	func inSeconds() -> Int {
		return inMinutes() * 60 + second
	}

	func inMinutes() -> Int {
		return hour * 60 + minute
	}

	static func fromSeconds(seconds: Int) -> TimePeriod {
		let second = seconds % 60
		let minutes = seconds / 60
		let minute = minutes % 60
		let hours = minutes / 60
		return TimePeriod(hour: hours, minute: minute, second: second)
	}

	static func < (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
		return lhs.inSeconds() < rhs.inSeconds()
	}

	static func + (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() + rhs.inSeconds())
	}

	static func - (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() - rhs.inSeconds())
	}

	static func / (lhs: TimePeriod, rhs: TimePeriod) -> Int {
		return lhs.inSeconds() / rhs.inSeconds()
	}

	static func * (lhs: TimePeriod, rhs: Int) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() * rhs)
	}
}

