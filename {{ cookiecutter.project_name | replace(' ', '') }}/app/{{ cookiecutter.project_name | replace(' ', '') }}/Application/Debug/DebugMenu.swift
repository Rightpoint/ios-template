//
//  DebugMenu.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by Brian King on 10/25/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Swiftilities
import Services
import Crashlytics

class DebugMenu {

    static func enableDebugGesture(_ viewController: UIViewController) {
        let debugGesture = UITapGestureRecognizer(target: self, action: #selector(openDebugAlert))
        debugGesture.numberOfTapsRequired = 4
        debugGesture.numberOfTouchesRequired = 1
        viewController.view.addGestureRecognizer(debugGesture)
    }

    @objc static func openDebugAlert() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate,
            let rootViewController = delegate.window?.rootViewController else {
                Log.warn("Debug alert unable to present since the window rootViewController is nil")
                return
        }
        var topMostViewController: UIViewController? = rootViewController
        while topMostViewController?.presentedViewController != nil {
            topMostViewController = topMostViewController?.presentedViewController!
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
        debug.addAction(UIAlertAction(title: "Text Styles", style: .default, handler: { _ in
            let vc = UINavigationController(rootViewController: DebugTextStyleViewController())
            topMostViewController?.present(vc, animated: true, completion: nil)
        }))

        debug.addAction(UIAlertAction(title: "Invalidate Refresh Token", style: .default, handler: { _ in
            APIClient.shared.oauthClient.credentials?.refreshToken = "BAD ACCESS TOKEN"
        }))
        debug.addAction(UIAlertAction(title: "Invalidate Access Token", style: .default, handler: { _ in
            APIClient.shared.oauthClient.credentials?.accessToken = "THIS IS A BAD DEBUG TOKEN"
        }))
        debug.addAction(UIAlertAction(title: "Crash", style: .default, handler: { _ in
            Crashlytics.sharedInstance().crash()
        }))
        debug.addAction(UIAlertAction(title: "Logout", style: .default, handler: { _ in
            APIClient.shared.oauthClient.logout(completion: { (error) in
                NSLog("Logout: \(String(describing: error))")
            })
        }))
        debug.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel, handler: nil))

        topMostViewController?.present(debug, animated: true, completion: nil)
    }
}
