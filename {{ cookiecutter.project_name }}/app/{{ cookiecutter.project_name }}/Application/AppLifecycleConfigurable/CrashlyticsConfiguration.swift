//
//  CrashlyticsConfiguration.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Fabric
import Crashlytics
import UIKit

struct CrashReportingConfiguration: AppLifecycleConfigurable {

    var enabledBuildTypes: [BuildType] {
        return [.Internal, .Release]
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        Fabric.with([Crashlytics.self])
    }

}
