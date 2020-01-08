//
//  AnywhereFitnessUITests.swift
//  AnywhereFitnessUITests
//
//  Created by Lambda_School_Loaner_204 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import XCTest

class AnywhereFitnessUITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        continueAfterFailure = false
        app.launch()
    }

    func testInitalWelcomeUser() {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["Welcome User!"].exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
