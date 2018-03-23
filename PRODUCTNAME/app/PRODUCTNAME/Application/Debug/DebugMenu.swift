//
//  DebugMenu.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 10/25/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Swiftilities
import Services
import Crashlytics

class DebugMenu {

    static func enableDebugGesture(_ viewController: UIViewController) {
        let debugGesture = UITapGestureRecognizer(target: self, action: #selector(openDebugAlert))
        debugGesture.numberOfTapsRequired = 3
        debugGesture.numberOfTouchesRequired = 2
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

        let debug = UINavigationController(rootViewController: DebugMenuViewController())
        topMostViewController?.present(debug, animated: true, completion: nil)
    }
}
