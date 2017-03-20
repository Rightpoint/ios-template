//
//  AnalyticsConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Swiftilities
import UIKit

struct AnalyticsConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return true
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        DefaultBehaviors(behaviors: [GoogleTrackPageViewBehavior()]).inject()
    }
}
