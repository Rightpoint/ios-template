//
//  StatusBarConfiguration.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

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
