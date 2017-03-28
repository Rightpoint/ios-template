//
//  Analytics.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 1/13/17.
//  Copyright © 2017 {{ cookiecutter.company_name }} All rights reserved.
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
