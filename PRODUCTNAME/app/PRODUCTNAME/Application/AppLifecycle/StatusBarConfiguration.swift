//
//  StatusBarConfiguration.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit

#if targetEnvironment(simulator) && DEBUG
    import SimulatorStatusMagic
#endif

struct StatusBarConfiguration: AppLifecycle {

    var isEnabled: Bool {
        return ProcessInfo.isRunningUITests
    }

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        #if targetEnvironment(simulator) && DEBUG
            SDStatusBarManager.sharedInstance().enableOverrides()
        #endif
    }

}
