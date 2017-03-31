//
//  AppCoordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow
    fileprivate let rootController: UIViewController
<<<<<<< HEAD
    var childCoordinator: Coordinator?
=======
    var childCoordinators = [Coordinator]()
>>>>>>> feature/nevillco/coordinators

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
<<<<<<< HEAD
        childCoordinator = authCoordinator
=======
        childCoordinators.append(authCoordinator)
>>>>>>> feature/nevillco/coordinators
        authCoordinator.start()
    }

    func cleanup() {
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

    func didSignIn() {
<<<<<<< HEAD
        guard let authCoordinator = childCoordinator as? AuthCoordinator else {
            preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        }
        childCoordinator = nil
=======
        guard let (index, authCoordinator) = child(ofType: AuthCoordinator.self) else {
            preconditionFailure("On didSignIn, we should have an AuthCoordinator in our list of coordinators.")
        }
        childCoordinators.remove(at: index)
>>>>>>> feature/nevillco/coordinators
        authCoordinator.cleanup()

        let contentCoordinator = ContentCoordinator(rootController)
        contentCoordinator.start()
<<<<<<< HEAD
        childCoordinator = contentCoordinator
=======
        childCoordinators.append(contentCoordinator)
>>>>>>> feature/nevillco/coordinators
    }

}
