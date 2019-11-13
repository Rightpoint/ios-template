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

extension FirebaseAnalytics {
    func configureApplication(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

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
                return false
        }
        FirebaseApp.configure(options: options)
        return true
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
