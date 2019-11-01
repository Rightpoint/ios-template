//
//  FirebaseAnalytics.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Foundation
import Firebase
import Swiftilities
import Services

class FirebaseAnalytics {

    static let shared: FirebaseAnalytics = { () -> FirebaseAnalytics in
        let sh = FirebaseAnalytics()
        sh.configure()
        return sh
    }()

    fileprivate func configure() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}

extension FirebaseAnalytics: AnalyticsService {

    func trackPageView(page: String) {
        print("Page sent to firebase: " + page)
        Analytics.setScreenName(page, screenClass: page)
    }

}

public class FirebaseTrackPageViewBehavior: ViewControllerLifecycleBehavior {

    public init() {}
    public func afterAppearing(_ viewController: UIViewController, animated: Bool) {
        FirebaseAnalytics.shared.track(viewController)
    }
}
