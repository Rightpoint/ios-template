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
        guard let rootController = AppDelegate.shared?.window?.rootViewController else {
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

    func cleanup() {
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

    func didSignIn() {
        guard let (index, authCoordinator) = child(ofType: AuthCoordinator.self) else {
            preconditionFailure("On didSignIn, we should have an AuthCoordinator in our list of coordinators.")
        }
        childCoordinators.remove(at: index)
        authCoordinator.cleanup()

        let contentCoordinator = ContentCoordinator(baseController)
        contentCoordinator.start()
        childCoordinators.append(contentCoordinator)
    }

}
