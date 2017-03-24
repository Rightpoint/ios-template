//
//  AppCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let rootController: UIViewController

    init() {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else {
            preconditionFailure("Initializing an AppCoordinator requires a root view controller.")
        }
        self.rootController = rootController
    }

    func start() {
    }

}
