//
//  LoggingConfiguration.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import UIKit
import Swiftilities

struct LoggingConfiguration: AppLifecycleConfigurable {

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        Log.logLevel = .info
    }

}
