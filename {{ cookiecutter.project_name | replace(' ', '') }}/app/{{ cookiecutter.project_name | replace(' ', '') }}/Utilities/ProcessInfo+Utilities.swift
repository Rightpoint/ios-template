//
//  ProcessInfo+Utilities.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation

extension ProcessInfo {

    static let uiTestsKey = "com.raizlabs.uiTests"

    static var isRunningUITests: Bool {
        // If you want to run the app in Debug mode, but have it pretend that it
        // is running UI tests, for purposes of testing with fake data or the like,
        // return true here.
        #if targetEnvironment(simulator)
            return ProcessInfo.processInfo.environment[ProcessInfo.uiTestsKey] == "true"
        #else
            return false
        #endif
    }

}
