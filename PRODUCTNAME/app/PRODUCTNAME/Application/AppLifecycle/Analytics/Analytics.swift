//
//  Analytics.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 1/13/17.
//  Copyright © 2017 ORGANIZATION All rights reserved.
//

import UIKit

public protocol AnalyticsService {

    func trackPageView(page: String)

}

extension AnalyticsService {

    public func track(_ viewController: UIViewController) {

        if let pageName = viewController.analyticsPageName {
            trackPageView(page: pageName)
        }

    }

}
