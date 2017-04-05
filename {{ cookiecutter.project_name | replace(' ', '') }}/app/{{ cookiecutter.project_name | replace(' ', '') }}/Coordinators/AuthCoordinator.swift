//
//  AuthCoordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate: class {

    func didSignIn()

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
