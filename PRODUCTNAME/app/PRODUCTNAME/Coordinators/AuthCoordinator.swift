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
            delegate?.didSignIn()
        }
        else if UserDefaults.hasOnboarded {
            let signInCoordinator = SignInCoordinator(baseController)
            signInCoordinator.delegate = self
            signInCoordinator.start()
            childCoordinators.append(signInCoordinator)
        }
        else {
            let onboardCoordinator = OnboardingCoordinator(baseController)
            onboardCoordinator.start()
            childCoordinators.append(onboardCoordinator)
        }
    }

    func cleanup() {
        // TODO - what should be done here?
        baseController.dismiss(animated: false, completion: nil)
    }

}

extension AuthCoordinator: SignInCoordinatorDelegate {

    func didSignIn() {
        delegate?.didSignIn()
    }

}
