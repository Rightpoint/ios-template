//
//  LoggingConfiguration.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Swiftilities
import Services

struct LoggingConfiguration: AppLifecycle {

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        Log.logLevel = .info
        NetworkLog.logLevel = .info
    }

}
