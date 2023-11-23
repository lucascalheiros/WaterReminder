//
//  ScopedExtensions.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 31/05/23.
//

import Foundation

/**
 Same functioning as kotlin counterparts, nice to reduce swift nil check verbosity :)
 */
public extension Optional {
	func unwrapLet<A>(function: (Wrapped) -> A) -> A? {
		if let some = self {
			return function(some)
		}
		return nil
	}

	func unwrapAlso<A>(function: (Wrapped) -> A) -> A? {
		if let some = self {
			return function(some)
		}
		return nil
	}

	func run<A>(function: (Wrapped) -> A) -> A? {
		if let some = self {
			return function(some)
		}
		return nil
	}

	func also(function: (Wrapped) -> Void) -> Wrapped? {
		if let some = self {
			function(some)
			return some
		}
		return nil
	}
}

infix operator |||

func ||| <T, A>(value: T, function: (T) -> A) -> A {
	function(value)
}
