//
//  BuildType.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation

/// A representation of the current build type, driven by SWIFT_ACTIVE_COMPILATION_CONDITIONS flags.
/// These compiler flags are configured in the Config specific `.xcconfig` file.
public enum BuildType {

    /// Debug build (-D DEBUG)
    case debug

    /// Internal build, configured as release but not for App Store submission (RZINTERNAL)
    case `internal`

    /// App store Release build, no flags
    case release

    /// The active BuildType
    public static var active: BuildType {
        #if DEBUG
            return .debug
        #elseif RZINTERNAL
            return .internal
        #else
            return .release
        #endif
    }

}
