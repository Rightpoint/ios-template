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
    }

}

extension AuthCoordinator: SignInCoordinatorDelegate {

    func didSignIn() {
        delegate?.didSignIn()
    }

}

extension AuthCoordinator: OnboardingCoordinatorDelegate {

    func didCompleteOnboarding() {
        guard let (index, onboardCoordinator) = child(ofType: OnboardingCoordinator.self) else {
            preconditionFailure("On didCompleteOnboarding, we should have an OnboardingCoordinator in our list of coordinators.")
        }
        childCoordinators.remove(at: index)
        onboardCoordinator.cleanup()

        let signInCoordinator = SignInCoordinator(baseController)
        signInCoordinator.delegate = self
        signInCoordinator.start()
        childCoordinators.append(signInCoordinator)
    }
}
