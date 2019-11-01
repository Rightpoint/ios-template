//
//  AnalyticsConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Firebase
import Swiftilities
import Services
import UIKit

struct AnalyticsConfiguration: AppLifecycle, PageNameConfiguration {

    // By default page names are the VC class name minus the suffix "ViewController" converted from camel case to title case. Adding a class to this list will use the provided string for that view controller.
    // e.g. ObjectIdentifier(SigninViewController.self): "Sign in",
    static let nameOverrides: [ObjectIdentifier: String] = [:]

    // Add any ViewControllers that you don't want to see in Analytics to the ignoreList
    // e.g. HomeTabBarViewController isn't really a screen to be tracked
    static let ignoreList: [ObjectIdentifier] = []

    var isEnabled: Bool {
        return true
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        var filePath: String?
        switch BuildType.active {
        case .debug:
            filePath = Bundle.main.path(forResource: "GoogleService-Info-Debug", ofType: "plist")
        case .internal:
            filePath = Bundle.main.path(forResource: "GoogleService-Info-Develop", ofType: "plist")
        case .release:
            filePath = Bundle.main.path(forResource: "GoogleService-Info-AppStore", ofType: "plist")
        }
        guard let path = filePath,
            let options = FirebaseOptions(contentsOfFile: path) else {
                Log.error("Firebase configuration not found!")
                return
        }
        FirebaseApp.configure(options: options)

        var behaviors: [ViewControllerLifecycleBehavior] = []
        switch BuildType.active {
        case .release:
            behaviors = [
                FirebaseTrackPageViewBehavior(),
            ]
        default: break
        }

        DefaultBehaviors(behaviors: behaviors).inject()
    }
}
