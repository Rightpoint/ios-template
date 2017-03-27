//
//  AppCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow
    let baseController: UIViewController
    var childCoordinators = [Coordinator]()

    init() {
        guard let window = AppDelegate.shared?.window else {
            preconditionFailure("Initializing an AppCoordinator requires a window.")
        }
        self.window = window
        let rootController = UIViewController()
        rootController.view.backgroundColor = .white
        self.baseController = rootController
    }

    func start() {
        // Configure window/root view controller
        window.setRootViewController(baseController, animated: false)
        window.makeKeyAndVisible()

        // Spin off auth coordinator
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
