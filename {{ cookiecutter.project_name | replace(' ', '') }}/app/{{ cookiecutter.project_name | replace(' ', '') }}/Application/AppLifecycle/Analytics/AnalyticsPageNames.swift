//
//  AnalyticsPageNames.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

protocol PageNameConfiguration {
    static var nameOverrides: [ObjectIdentifier: String] { get }
    static var ignoreList: [ObjectIdentifier] { get }
}

extension UIViewController {

    var analyticsPageName: String? {
        return AnalyticsPageName.for(self)
    }

    var isSystemClass: Bool {
        let classBundle = Bundle(for: type(of: self))
        return !classBundle.bundlePath.hasPrefix(Bundle.main.bundlePath)
    }

}

private enum AnalyticsPageName {

    static func `for`(_ className: String) -> String? {
        var pageName = className

        if let range = pageName.range(of: "ViewController", options: [.backwards, .anchored], range: nil, locale: nil) {
            pageName.removeSubrange(range)
        }
        return pageName.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression, range: pageName.startIndex..<pageName.endIndex)
    }

    static func `for`(_ viewController: UIViewController) -> String? {
        let identifier = ObjectIdentifier(type(of: viewController))

        if let pageName = AnalyticsConfiguration.nameOverrides[identifier] {
            return pageName
        } else if !AnalyticsConfiguration.ignoreList.contains(identifier),
            !viewController.isSystemClass {
            let className = String(describing: type(of: viewController))
            return AnalyticsPageName.for(className)
        } else {
            return nil
        }
    }
}
