//
//  VerticalTimeWheelPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/11/23.
//

import Foundation
import UIKit
import Common
import Core

open class TimePeriodPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

	open var dayTime: [TimePeriod] = Array()
	open var valueChangeListener: ((TimePeriodPickerView) -> Void)?

    open var initialTimeIndex: Int = 0
	open var finalTimeIndex: Int = 0

	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
	}
	
    required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    open func updateData(dayTime: [TimePeriod]) {
		self.dayTime = dayTime
        reloadAllComponents()
	}

    open override func selectRow(_ row: Int, inComponent: Int, animated: Bool) {
        switch Sections.allCases[safe: inComponent] {
        case .initialTime:
            initialTimeIndex = row
        case .finalTime:
            finalTimeIndex = row
        default:
            break
        }
		super.selectRow(row, inComponent: inComponent, animated: animated)
	}
	
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Sections.allCases.count
	}
	
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayTime.count
	}

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
	}

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch Sections.allCases[safe: component] {
        case .initialTime, .finalTime:
			return dayTime[row].hourAndMinuteAsString()
		default:
			return ""
		}
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
        label.font = UIFont.h3
		return label
	}

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch Sections.allCases[safe: component] {
        case .initialTime:
			initialTimeIndex = row
            limitInitialPickerValue()
        case .finalTime:
            finalTimeIndex = row
            limitFinalPickerValue()
		default:
			break
		}
		valueChangeListener?(self)
	}

    private func limitInitialPickerValue() {
        if (initialTimeIndex > finalTimeIndex) {
            selectRow(initialTimeIndex, inComponent: Sections.allCases.firstIndex(of: .finalTime)!, animated: true)
        }
    }

    private func limitFinalPickerValue() {
        if (initialTimeIndex > finalTimeIndex) {
            selectRow(finalTimeIndex, inComponent: Sections.allCases.firstIndex(of: .initialTime)!, animated: true)
        }
    }

    enum Sections: CaseIterable {
        case initialTime
        case finalTime
    }
}
