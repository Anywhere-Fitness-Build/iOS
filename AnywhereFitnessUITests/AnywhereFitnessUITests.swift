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

        let usernameTextField = app.textFields["LoginViewController.usernameTextField"]
        let passwordTextField = app.textFields["LoginViewController.passwordTextField"]
        let loginButton = app.buttons["LoginViewController.loginButton"]
        XCTAssert(usernameTextField.exists)
        XCTAssert(passwordTextField.exists)
        XCTAssert(loginButton.exists)
        usernameTextField.tap()
        usernameTextField.typeText("test")
        passwordTextField.tap()
        UIPasteboard.general.string = "password"
        passwordTextField.doubleTap()
        app.menuItems["Paste"].tap()

        let title = app.navigationBars["Welcome test!"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: title, handler: nil)

        loginButton.tap()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(title.exists)
    }

    func testSignUp() {
        let app = XCUIApplication()
        let signUpButton = app.buttons["LoginViewController.signupButton"]
        XCTAssert(signUpButton.exists)
        signUpButton.tap()
        let signUpLabel = app.staticTexts["Sign Up"]
        XCTAssert(signUpLabel.exists)

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
