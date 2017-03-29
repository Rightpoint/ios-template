//
//  AppDelegate.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    var coordinator: AppCoordinator!
    var window: UIWindow?

    // Anything that doesn't rely on the existence of a viewcontroller should be in this preWindowConfigurations array
    let preWindowConfigurations: [AppLifecycle] = [
        LoggingConfiguration(),
        InstabugConfiguration(),
        Appearance.shared,
        CrashReportingConfiguration(),
        AnalyticsConfiguration(),
        ]

    // Anything that relies on the existence of a window and an initial viewcontroller should be in this postWindowConfigurations array
    let rootViewControllerDependentConfigurations: [AppLifecycle] = [
        DebugMenuConfiguration(),
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        for config in preWindowConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        self.coordinator = AppCoordinator(window: window)
        coordinator.start()

        for config in rootViewControllerDependentConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        return true
    }

}
