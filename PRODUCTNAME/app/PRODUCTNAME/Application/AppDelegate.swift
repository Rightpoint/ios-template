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

    let configurations: [AppLifecycle] = [
        LoggingConfiguration(),
        InstabugConfiguration(),
        Appearance.shared,
        CrashReportingConfiguration(),
        DebugMenuConfiguration(),
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        showTabBar(animated: false)
        window?.makeKeyAndVisible()

        for config in configurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        return true
    }

    func showTabBar(animated: Bool) {
        // Dismiss the root view controller if one exists. This approach allows us to switch between the main experience, login and onboarding folows
        window?.rootViewController?.dismiss(animated: false, completion: nil)

        let tabBarVC = UITabBarController()
        let firstTab = UIViewController()
        firstTab.view.backgroundColor = UIColor.white // Forces loadView
        tabBarVC.setViewControllers([firstTab], animated: false)

        window?.setRootViewController(tabBarVC, animated: animated)
    }
}
