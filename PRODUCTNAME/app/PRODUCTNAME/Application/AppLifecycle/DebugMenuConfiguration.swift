//
//  DebugMenuConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit
import Swiftilities

class DebugMenuConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return BuildType.active == .internal || BuildType.active == .debug
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        DefaultBehaviors(behaviors: [DebugMenuBehavior()]).inject()
    }

}

fileprivate class DebugMenu {
    static let shared: DebugMenu = DebugMenu()

    func enableDebugGesture(_ viewController: UIViewController) {
        let debugGesture = UITapGestureRecognizer(target: self, action: #selector(openDebugAlert))
        debugGesture.numberOfTapsRequired = 3
        debugGesture.numberOfTouchesRequired = 2
        viewController.view.addGestureRecognizer(debugGesture)
    }

    @objc func openDebugAlert() {
        guard let rootViewController = AppDelegate.shared?.window?.rootViewController else {
            Log.warn("Debug alert unable to present since the window rootViewController is nil")
            return
        }

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
                NSLog("Logout: \(String(describing: error))")
            })
        }))
        debug.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel, handler: nil))

        var topMostViewController: UIViewController? = rootViewController
        while topMostViewController?.presentedViewController != nil {
            topMostViewController = topMostViewController?.presentedViewController!
        }
        topMostViewController?.present(debug, animated: true, completion: nil)
    }
}

public class DebugMenuBehavior: ViewControllerLifecycleBehavior {

    public init() {}
    public func afterAppearing(_ viewController: UIViewController, animated: Bool) {
        DebugMenu.shared.enableDebugGesture(viewController)
    }

}
