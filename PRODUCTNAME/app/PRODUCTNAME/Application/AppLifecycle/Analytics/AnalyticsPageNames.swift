//
//  AnalyticsPageNames.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 1/13/17.
//  Copyright © 2017 ORGANIZATION All rights reserved.
//

import UIKit

protocol PageNameConfiguration {
    static var nameOverrides: [ObjectIdentifier : String] { get }
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

    static func `for`(_ viewController: UIViewController) -> String? {
        let identifier = ObjectIdentifier(type(of: viewController))

        if let pageName = AnalyticsConfiguration.nameOverrides[identifier] {
            return pageName
        }
        else if !AnalyticsConfiguration.ignoreList.contains(identifier),
            !viewController.isSystemClass {
            var className = String(describing: type(of: viewController))

            if let range = className.range(of: "ViewController", options: [.backwards, .anchored], range: nil, locale: nil) {
                className.removeSubrange(range)
            }
            return className.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression, range: className.startIndex..<className.endIndex)
        }
        else {
            return nil
        }
    }
}
