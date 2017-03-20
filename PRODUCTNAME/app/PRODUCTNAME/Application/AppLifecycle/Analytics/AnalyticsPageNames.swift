//
//  AnalyticsPageNames.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 1/13/17.
//  Copyright © 2017 ORGANIZATION All rights reserved.
//

import UIKit

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

    // By default page names are the VC class name minus the suffix "ViewController" converted from camel case to title case. Adding a class to this list will use the provided string for that view controller.
    // e.g. ObjectIdentifier(SigninViewController.self): "Sign in",
    static let nameOverrides: [ObjectIdentifier : String] = [:]
    // static let nameOverrides: [ObjectIdentifier : String] = [
    //    ObjectIdentifier(SigninViewController.self): "Sign in",
    // ]

    // Add any ViewControllers that you don't want to see in Analytics to the ignoreList 
    // e.g. HomeTabBarViewController isn't really a screen to be tracked
    static let ignoreList = [
        ObjectIdentifier(UINavigationController.self),
        // ObjectIdentifier(HomeTabBarViewController.self),
    ]

    static func `for`(_ viewController: UIViewController) -> String? {
        let identifier = ObjectIdentifier(type(of: viewController))

        if let pageName = nameOverrides[identifier] {
            return pageName
        }
        else if !ignoreList.contains(identifier),
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
