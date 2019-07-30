//
//  CrashlyticsConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Fabric
import Crashlytics
import UIKit
import Services

struct CrashReportingConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return BuildType.active != .debug
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        Fabric.with([Crashlytics.self])
    }

}
