//
//  AppCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow
    fileprivate let rootController: UIViewController
    var childCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
        let rootController = UIViewController()
        rootController.view.backgroundColor = .white
        self.rootController = rootController
    }

    func start() {
        // Configure window/root view controller
        window.setRootViewController(rootController, animated: false)
        window.makeKeyAndVisible()

        // Spin off auth coordinator
        let authCoordinator = AuthCoordinator(rootController)
        authCoordinator.delegate = self
        childCoordinator = authCoordinator
        authCoordinator.start()
    }

    func cleanup() {
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

    func didSignIn() {
        assert(childCoordinator is AuthCoordinator, "Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        childCoordinator = nil
        childCoordinator?.cleanup()

        let contentCoordinator = ContentCoordinator(rootController)
        contentCoordinator.start()
        childCoordinator = contentCoordinator
    }

    func didSkipAuth() {
        assert(childCoordinator is AuthCoordinator, "Upon skipping authentication, AppCoordinator should have an AuthCoordinator as a child.")
        childCoordinator?.cleanup()
        childCoordinator = nil

        let contentCoordinator = ContentCoordinator(rootController)
        contentCoordinator.start()
        childCoordinator = contentCoordinator
    }

}
