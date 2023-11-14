//
//  AppColorGroupTest.swift
//  WaterReminderTests
//
//  Created by Lucas Calheiros on 10/11/23.
//

import XCTest
import Core
@testable import WaterReminder

final class AppColorGroupTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColorPresent() throws {
        for color in AppColorGroup.allCases {
            XCTAssertNoThrow(color.color)
        }
    }

    func testOnColorPresent() throws {
        for color in AppColorGroup.allCases {
            XCTAssertNoThrow(color.onColor)
        }
    }

    func testOnColorVariantPresent() throws {
        for color in AppColorGroup.allCases {
            XCTAssertNoThrow(color.onColorVariant)
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
