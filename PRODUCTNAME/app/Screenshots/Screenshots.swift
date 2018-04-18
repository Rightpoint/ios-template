//
//  Screenshots.swift
//  Screenshots
//
//  Created by Zev Eisenberg on 4/3/18.
//  Copyright © 2018 ORGANIZATION. All rights reserved.
//

import XCTest

class Screenshots: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchEnvironment[ProcessInfo.uiTestsKey] = "true"
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOnboarding() {
        XCTAssertTrue(XCUIApplication().buttons["Skip"].waitForExistence(timeout: 5))
        snapshot("Onboarding-1")
        XCUIApplication().buttons["Skip"].tap()
        snapshot("Onboarding-2")
    }

}
