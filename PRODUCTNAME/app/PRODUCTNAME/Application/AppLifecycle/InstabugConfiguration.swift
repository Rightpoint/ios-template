//
//  InstabugConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Instabug
import UIKit
import Services

struct InstabugConfiguration: AppLifecycle {

    private static let instabugTokenKey = "InstabugToken"

    var isEnabled: Bool {
        return BuildType.active == .internal
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let token = Bundle.main.object(forInfoDictionaryKey: InstabugConfiguration.instabugTokenKey) as? String, !token.isEmpty {
            Instabug.start(withToken: token, invocationEvents: [.shake])
        }
        BugReporting.bugReportingOptions = .emailFieldOptional
        CrashReporting.enabled = false
    }

}
