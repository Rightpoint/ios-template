//
//  SignInCoordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/27/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

protocol SignInCoordinatorDelegate: class {

    func didSignIn()

}

class SignInCoordinator: Coordinator {

    let baseController: UIViewController
<<<<<<< HEAD
    var childCoordinator: Coordinator?
=======
    var childCoordinators = [Coordinator]()
>>>>>>> feature/nevillco/coordinators
    weak var delegate: SignInCoordinatorDelegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        // TODO - create and use SignInViewController
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        // Wrapped in dispatch block to ensure this happens on the next run loop
        // after the root is configured, to prevent "Unbalanced calls to begin/
        // "end appearance transitions" warning. Necessary for any controllers
        // presented directly off of the root controller.
        DispatchQueue.main.async {
            self.baseController.present(vc, animated: false, completion: nil)
        }
    }

    func cleanup() {
<<<<<<< HEAD
=======
        baseController.dismiss(animated: false, completion: nil)
>>>>>>> feature/nevillco/coordinators
    }

}
