//
//  FirebaseAnalytics.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
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
