//
//  InstabugConfiguration.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Instabug
import UIKit

struct InstabugConfiguration: AppLifecycleConfigurable {
    var enabledBuildTypes: [BuildType] {
        return [.Internal]
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        Instabug.start(withToken: "INSERT_TOKEN_HERE", invocationEvent: .shake)
        Instabug.setEmailFieldRequired(false)
        Instabug.setCrashReportingEnabled(false)
    }

}
