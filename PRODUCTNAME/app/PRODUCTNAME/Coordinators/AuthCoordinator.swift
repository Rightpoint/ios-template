//
//  AuthCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate: class {

    func didSignIn()

}

class AuthCoordinator: Coordinator {

    var childCoordinator: Coordinator?
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
            childCoordinator = signInCoordinator
        }
        else {
            let onboardCoordinator = OnboardingCoordinator(baseController)
            onboardCoordinator.delegate = self
            onboardCoordinator.start()
            childCoordinator = onboardCoordinator
        }
    }

    func cleanup() {
        childCoordinator?.cleanup()
    }

}

extension AuthCoordinator: SignInCoordinatorDelegate {

    func didSignIn() {
        delegate?.didSignIn()
    }

}

extension AuthCoordinator: OnboardingCoordinatorDelegate {

    func didSkipAuth() {
        childCoordinator?.cleanup()
        childCoordinator = nil

        let contentCoordinator = ContentCoordinator(baseController)
        contentCoordinator.start()
        childCoordinator = contentCoordinator
    }

    func didRequestJoin() {
        childCoordinator?.cleanup()
        childCoordinator = nil

        let signInCoordinator = SignInCoordinator(baseController)
        signInCoordinator.delegate = self
        signInCoordinator.start()
        // TODO - signInCoordinator move from signIn to register here
        childCoordinator = signInCoordinator
    }

    func didRequestSignIn() {
        childCoordinator?.cleanup()
        childCoordinator = nil

        let signInCoordinator = SignInCoordinator(baseController)
        signInCoordinator.delegate = self
        signInCoordinator.start()
        childCoordinator = signInCoordinator
    }

}
