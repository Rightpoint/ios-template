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

    func didCompleteOnboarding() {
        guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
            preconditionFailure("Upon completing onboarding, AuthCoordinator should have an OnboardingCoordinator as a child.")
        }
        onboardCoordinator.cleanup()
        childCoordinator = nil

        let signInCoordinator = SignInCoordinator(baseController)
        signInCoordinator.delegate = self
        signInCoordinator.start()
        childCoordinator = signInCoordinator
    }
}
