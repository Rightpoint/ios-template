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
    func didSkipAuth()

}

private enum State {

    case authenticated
    case onboarded
    case needsOnboarding

}

class AuthCoordinator: Coordinator {

    var childCoordinator: Coordinator?
    let baseController: UIViewController
    weak var delegate: AuthCoordinatorDelegate?

    private let client = APIClient()
    private var state: State {
        if client.oauthClient.isAuthenticated {
            return .authenticated
        }
        else if UserDefaults.hasOnboarded {
            return .onboarded
        }
        else {
            return .needsOnboarding
        }
    }

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        switch state {
        case .authenticated:
            delegate?.didSignIn()
        case .onboarded:
            let signInCoordinator = SignInCoordinator(baseController)
            signInCoordinator.delegate = self
            signInCoordinator.start()
            childCoordinator = signInCoordinator
        case .needsOnboarding:
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
        delegate?.didSkipAuth()
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
