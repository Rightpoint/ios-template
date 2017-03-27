//
//  SignInCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol SignInCoordinatorDelegate: class {

    func didSignIn()

}

class SignInCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinators = [Coordinator]()
    weak var delegate: SignInCoordinatorDelegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        // TODO - launch sign in controller
    }

    func cleanup() {
        baseController.dismiss(animated: false, completion: nil)
    }

}
