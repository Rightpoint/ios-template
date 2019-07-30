//
//  {{ cookiecutter.project_name | replace(' ', '') }}Tests.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}Tests
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import XCTest
@testable import {{ cookiecutter.project_name | replace(' ', '') }}

class {{ cookiecutter.project_name | replace(' ', '') }}Tests: XCTestCase {
    func testUserDefaults() {
        XCTAssertFalse(UserDefaults.hasOnboarded)
    }
}
