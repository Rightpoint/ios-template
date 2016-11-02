//
//  Appearance.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

struct Appearance {
    static var shared = Appearance()

    func style() {
        // Configure UIAppearance proxies
    }
}

extension Appearance: AppLifecycleConfigurable {
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        style()
    }
}
