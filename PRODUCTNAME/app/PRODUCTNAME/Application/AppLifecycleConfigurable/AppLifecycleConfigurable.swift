//
//  AppLifecycleConfigurable.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import UIKit

/**
 *  Objects conforming to this protocol provide some sort of configurable behavior intended for execution
 *  on app launch.
 */
protocol AppLifecycleConfigurable {

    /// The build types to which the conforming instance applies.
    var enabledBuildTypes: [BuildType] { get }

    /**
     Invoked on UIApplication.applicationDidFinishLaunching to give the conforming instance a chance to execute configuration.

     - parameter application:   The application
     - parameter launchOptions: Optional launch options
     */
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?)

}

extension AppLifecycleConfigurable {

    var enabledBuildTypes: [BuildType] {
        return [.Debug, .Internal, .Release]
    }

    /// Whether or not this configurable instance is enabled for the current build type.
    var isEnabled: Bool {
        for buildType in self.enabledBuildTypes {
            if buildType.active {
                return true
            }
        }
        return false
    }

}
