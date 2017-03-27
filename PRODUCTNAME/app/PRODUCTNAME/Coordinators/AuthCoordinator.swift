//
//  AuthCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate: class {

    func didSignIn()

}

class AuthCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    let baseController: UIViewController
    weak var delegate: AuthCoordinatorDelegate?
    private let authClient = OAuthClient()

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        if authClient.isAuthenticated {
            cleanup()
            delegate?.didSignIn()
        }
        else if UserDefaults.hasOnboarded {
            // TODO - launch sign in
        }
        else {
            // TODO - launch onboarding
        }
    }

    func cleanup() {
        // TODO - what should be done here?
        baseController.dismiss(animated: false, completion: nil)
    }

}
