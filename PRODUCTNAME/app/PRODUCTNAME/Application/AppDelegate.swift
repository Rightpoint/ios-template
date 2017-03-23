//
//  AppDelegate.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Anything that doesn't rely on the existence of a window should be in this preWindowConfigurations array
    let preWindowConfigurations: [AppLifecycle] = [
        LoggingConfiguration(),
        InstabugConfiguration(),
        Appearance.shared,
        CrashReportingConfiguration(),
        AnalyticsConfiguration(),
        ]

    // Anything that relies on the existence of a window and an initial viewcontroller should be in this postWindowConfigurations array
    let postWindowConfigurations: [AppLifecycle] = [
        DebugMenuConfiguration(),
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        for config in preWindowConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        window = UIWindow(frame: UIScreen.main.bounds)

        for config in postWindowConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        configureRootViewController(animated: false)
        window?.makeKeyAndVisible()

        return true
        }

    func configureRootViewController(animated: Bool) {
        // Dismiss the root view controller if one exists. This approach allows us to switch between the main experience, login and onboarding folows
        window?.rootViewController?.dismiss(animated: false, completion: nil)

        let tabBarVC = UITabBarController()
        let firstTab = FirstTabViewController()
        firstTab.view.backgroundColor = UIColor.white // Forces loadView
        tabBarVC.setViewControllers([firstTab], animated: false)

        window?.setRootViewController(tabBarVC, animated: animated)
    }
}
