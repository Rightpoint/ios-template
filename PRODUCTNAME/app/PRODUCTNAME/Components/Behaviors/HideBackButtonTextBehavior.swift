//
//  HideBackButtonTextBehavior.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 7/7/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Swiftilities

final class HidesBackButtonTextBehavior: ViewControllerLifecycleBehavior {

    static let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    func beforeAppearing(_ viewController: UIViewController, animated: Bool) {
        if viewController.navigationItem.title == nil {
            viewController.navigationItem.backBarButtonItem = HidesBackButtonTextBehavior.backButton
        }
    }
}
