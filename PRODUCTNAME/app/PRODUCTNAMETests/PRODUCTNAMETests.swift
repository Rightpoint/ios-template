//
//  PRODUCTNAMETests.swift
//  PRODUCTNAMETests
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import XCTest
@testable import PRODUCTNAME

class PRODUCTNAMETests: XCTestCase {
    func testUserDefaults() {
        XCTAssertFalse(UserDefaults.hasOnboarded)
    }
}
