//
//  TimePeriod.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation

public struct TimePeriod: Comparable, Codable, Hashable {
	public let hour: Int
    public let minute: Int
    public let second: Int

	public init(hour: Int, minute: Int = 0, second: Int = 0) {
		let seconds = hour * 3600 + minute * 60 + second
		let second = seconds % 60
		let minutes = seconds / 60
		let minute = minutes % 60
		let hours = minutes / 60
		self.hour = hours
		self.minute = minute
		self.second = second
	}

    public func inSeconds() -> Int {
		return inMinutes() * 60 + second
	}

    public func inMinutes() -> Int {
		return hour * 60 + minute
	}

    public static func fromSeconds(seconds: Int) -> TimePeriod {
		let second = seconds % 60
		let minutes = seconds / 60
		let minute = minutes % 60
		let hours = minutes / 60
		return TimePeriod(hour: hours, minute: minute, second: second)
	}

	public static func < (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
		return lhs.inSeconds() < rhs.inSeconds()
	}

    public static func + (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() + rhs.inSeconds())
	}

    public static func - (lhs: TimePeriod, rhs: TimePeriod) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() - rhs.inSeconds())
	}

    public static func / (lhs: TimePeriod, rhs: TimePeriod) -> Int {
		return lhs.inSeconds() / rhs.inSeconds()
	}

    public static func * (lhs: TimePeriod, rhs: Int) -> TimePeriod {
		return TimePeriod.fromSeconds(seconds: lhs.inSeconds() * rhs)
	}

    public func hourAndMinuteAsString() -> String {
        return String(format: "%02d:%02d", hour, minute)
    }

}

