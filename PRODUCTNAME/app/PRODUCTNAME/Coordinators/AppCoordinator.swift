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

    func didSignIn() {
        guard let authCoordinator = childCoordinators.flatMap({ $0 as? AuthCoordinator }).first,
            let index = childCoordinators.index(where: { $0 is AuthCoordinator }) else {
            preconditionFailure("On didSignIn, we should have an AuthCoordinator in our list of coordinators.")
        }
        childCoordinators.remove(at: index)
        authCoordinator.cleanup()
        // TODO - launch child coordinator
    }

}
