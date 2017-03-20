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
        AnalyticsConfiguration(),
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        for config in configurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Adds (by default) a 2 finger triple tap gesture to present a debug menu
        enableDebugGesture()

        if let w = window {
            // Configure global window defaults
            w.backgroundColor = UIColor.white

            // Setting a tintcolor on the window adds a tint to all UIAlertControllers
            w.tintColor = UIColor.blue
        }

        configureInitialViewState()
        window?.makeKeyAndVisible()

        return true
    }

    func configureInitialViewState() {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        guard let launchScreen = storyboard.instantiateInitialViewController() else {
            let selector = #selector(UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:))
            preconditionFailure("We need to be able to instantiate the launch screen because we can't return from \(selector) without setting a root view controller. We're using the launch screen so that it looks like the launch screen is just visible for a moment longer, rather than switching to some kind of progress spinner screen that flashes briefly and then disappears.")
        }

        self.window?.setRootViewController(launchScreen, animated: false)
        // Logic to replace root view controller should appear next e.g. !hasSeenOnboarding > show onboarding else continue to root vc
        // Show a default tab bar
        showTabBar(animated: true)
    }

    func showTabBar(animated: Bool) {
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        let homeVC = UITabBarController()
        let firstTabVC = FirstTabViewController()
        homeVC.setViewControllers([firstTabVC], animated: false)
        window?.setRootViewController(homeVC, animated: animated)
    }
}

extension AppDelegate {
    func enableDebugGesture() {
        let debugGesture = UITapGestureRecognizer(target: self, action: #selector(openDebugAlert))
        debugGesture.numberOfTapsRequired = 3
        debugGesture.numberOfTouchesRequired = 2
        window?.addGestureRecognizer(debugGesture)
    }

    func openDebugAlert() {
        var debug: UIAlertController

        if let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String {
            debug = UIAlertController(title: "Debug Menu \(version) (\(build))", message: nil, preferredStyle: .actionSheet)
        }
        else {
            debug = UIAlertController(title: "Debug Menu", message: nil, preferredStyle: .actionSheet)
        }
        debug.addAction(UIAlertAction(title: "Invalidate Refresh Token", style: .default, handler: { _ in
            APIClient.shared.oauthClient.credentials?.refreshToken = "BAD ACCESS TOKEN"
        }))
        debug.addAction(UIAlertAction(title: "Invalidate Access Token", style: .default, handler: { _ in
            APIClient.shared.oauthClient.credentials?.accessToken = "THIS IS A BAD DEBUG TOKEN"
        }))
        debug.addAction(UIAlertAction(title: "Logout", style: .default, handler: { _ in
            APIClient.shared.oauthClient.logout(completion: { (error) in
                NSLog("Logout: \(error)")
            })
        }))
        debug.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        window?.rootViewController?.present(debug, animated: true, completion: nil)
    }
}
