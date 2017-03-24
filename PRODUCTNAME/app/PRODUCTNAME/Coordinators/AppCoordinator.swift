//
//  AppCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinators = [Coordinator]()

    init() {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else {
            preconditionFailure("Initializing an AppCoordinator requires a root view controller.")
        }
        self.baseController = rootController
    }

    func start() {
        let authCoordinator = AuthCoordinator(baseController)
        authCoordinator.delegate = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

}
