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

    func start(animated: Bool, completion: VoidClosure?) {
        // Configure window/root view controller
        window.setRootViewController(rootController, animated: false, completion: {
            self.window.makeKeyAndVisible()

            // Spin off auth coordinator
            let authCoordinator = AuthCoordinator(self.rootController)
            authCoordinator.delegate = self
            self.childCoordinator = authCoordinator
            authCoordinator.start(animated: animated, completion: completion)
        })
    }

    func cleanup(animated: Bool, completion: VoidClosure?) {
        completion?()
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

    func didSignIn() {
        guard let authCoordinator = childCoordinator as? AuthCoordinator else {
            preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        }
        childCoordinator = nil
        authCoordinator.cleanup(animated: true, completion: {
            let contentCoordinator = ContentCoordinator(self.rootController)
            self.childCoordinator = contentCoordinator
            contentCoordinator.start(animated: true, completion: nil)
        })
    }

    func didSkipAuth() {
        guard let authCoordinator = childCoordinator as? AuthCoordinator else {
            preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        }
        childCoordinator = nil
        authCoordinator.cleanup(animated: true, completion: {
            let contentCoordinator = ContentCoordinator(self.rootController)
            self.childCoordinator = contentCoordinator
            contentCoordinator.start(animated: true, completion: nil)
        })
    }

}
