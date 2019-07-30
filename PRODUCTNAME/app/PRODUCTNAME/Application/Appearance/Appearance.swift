//
//  Appearance.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit

struct Appearance {
    static var shared = Appearance()

    func style() {
        // Configure UIAppearance proxies
    }
}

extension Appearance: AppLifecycle {
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        style()
    }
}
