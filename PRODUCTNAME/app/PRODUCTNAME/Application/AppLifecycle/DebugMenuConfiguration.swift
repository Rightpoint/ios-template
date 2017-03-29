//
//  DebugMenuConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import UIKit
import Swiftilities

class DebugMenuConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return BuildType.active == .internal || BuildType.active == .debug
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // Adds (by default) a 2 finger triple tap gesture to present a debug menu
        enableDebugGesture()

    }

    func enableDebugGesture() {
        let debugGesture = UITapGestureRecognizer(target: self, action: #selector(openDebugAlert))
        debugGesture.numberOfTapsRequired = 3
        debugGesture.numberOfTouchesRequired = 2
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.addGestureRecognizer(debugGesture)
        }
    }

    @objc func openDebugAlert() {
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
        debug.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController?.present(debug, animated: true, completion: nil)
        }
    }
}
