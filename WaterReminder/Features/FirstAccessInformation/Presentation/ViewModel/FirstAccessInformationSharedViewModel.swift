//
//  FirstAccessInformationSharedViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 31/05/23.
//

import Foundation
import RxRelay
import RxSwift

class FirstAccessInformationSharedViewModel {
	internal init(expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase) {
		self.expectedWaterConsumptionUseCase = expectedWaterConsumptionUseCase
	}
	
	let expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase

	let currentPageIndex = BehaviorRelay(value: 0)
	let totalPages = BehaviorRelay(value: 0)
	lazy var isLastPage = {
		Observable.combineLatest(
			currentPageIndex.asObservable(),
			totalPages.asObservable()
		) { currentPage, totalPages in
			currentPage + 1 == totalPages
		}
	}()
	lazy var isFirstPage = {
		currentPageIndex.map {
			$0 == 0
		}
	}()

	func setPage(page: Int) {
		currentPageIndex.accept(page)
	}

	func skipToLastPage() {
		currentPageIndex.accept(totalPages.value - 1)
	}

	func setTotalPages(total: Int) {
		totalPages.accept(total)
	}

	func setWeight(weightInGrams: Int) {

	}

	func setExerciseDays(exerciseDays: Int) {

	}

	func setTemperatureLevel() {
		
	}

}
