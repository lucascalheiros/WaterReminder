//
//  DayTimeSelectorPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/11/23.
//

import Foundation
import UIKit
import Common
import Combine

open class DayTimeSelectorPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    @Published open var dayTime = TimePeriod.fromSeconds(seconds: 0)

    open var hour: Int = 0
	open var minute: Int = 0

    private let hours = 0...23
    private let minutes = 0...59

	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
	}
	
    required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    open func updateData(dayTime: TimePeriod) {
		self.dayTime = dayTime
        reloadAllComponents()
	}

    open override func selectRow(_ row: Int, inComponent: Int, animated: Bool) {
        switch Sections.allCases[safe: inComponent] {
        case .hour:
            hour = row
        case .minute:
            minute = row
        default:
            break
        }
		super.selectRow(row, inComponent: inComponent, animated: animated)
	}
	
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Sections.allCases.count
	}
	
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch Sections.allCases[safe: component] {
        case .hour:
            return hours.count
        case .minute:
            return minutes.count
        default:
            break
        }
        return 0
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
	}

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch Sections.allCases[safe: component] {
        case .hour:
            return String(format: "%02dh", row)
        case .minute:
            return String(format: "%02dm", row)
        default:
            break
        }
        return nil
	}

    public func pickerView(
		_ pickerView: UIPickerView,
		viewForRow row: Int,
		forComponent component: Int,
		reusing view: UIView?
	) -> UIView {
		let string = self.pickerView(pickerView, titleForRow: row, forComponent: component) ?? ""
		let label = view as? UILabel ?? UILabel()
		label.text = string
		label.textColor = DefaultComponentsTheme.current.background.onColor
		label.textAlignment = .center
        label.font = DefaultComponentsTheme.current.h3
		return label
	}

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch Sections.allCases[safe: component] {
        case .hour:
			hour = row
        case .minute:
            minute = row
		default:
			break
		}
        dayTime = TimePeriod(hour: hour, minute: minute)
	}

    enum Sections: CaseIterable {
        case hour
        case minute
    }
}
