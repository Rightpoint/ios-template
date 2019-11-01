//
//  AppCenterConfiguration.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by Eliot Williams on 11/5/19.
//  Copyright © 2019 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
#if canImport(AppCenter)
import AppCenter
import AppCenterDistribute
#endif

struct AppCenterConfiguration: AppLifecycle {
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        #if canImport(AppCenter)
        guard let appSecret = Bundle.main.object(forInfoDictionaryKey: "AppCenterAppSecret") as? String else {
            return
        }
        MSAppCenter.start(appSecret, withServices: [MSDistribute.self])
        #endif
    }
}
