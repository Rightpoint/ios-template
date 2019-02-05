//
//  InstabugConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
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
        BugReporting.invocationOptions = .emailFieldOptional
        CrashReporting.enabled = false
    }

}
