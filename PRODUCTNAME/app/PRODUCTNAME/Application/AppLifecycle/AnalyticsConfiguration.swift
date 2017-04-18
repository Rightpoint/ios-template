//
//  AnalyticsConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Swiftilities
import UIKit

struct AnalyticsConfiguration: AppLifecycle, PageNameConfiguration {

    // By default page names are the VC class name minus the suffix "ViewController" converted from camel case to title case. Adding a class to this list will use the provided string for that view controller.
    // e.g. ObjectIdentifier(SigninViewController.self): "Sign in",
    static let nameOverrides: [ObjectIdentifier : String] = [:]

    // Add any ViewControllers that you don't want to see in Analytics to the ignoreList
    // e.g. HomeTabBarViewController isn't really a screen to be tracked
    static let ignoreList: [ObjectIdentifier] = []

    var isEnabled: Bool {
        return true
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        DefaultBehaviors(behaviors: [GoogleTrackPageViewBehavior()]).inject()
    }
}
