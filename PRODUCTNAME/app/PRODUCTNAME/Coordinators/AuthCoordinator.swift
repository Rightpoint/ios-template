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

    func start(animated: Bool, completion: VoidClosure?) {
        switch state {
        case .authenticated:
            delegate?.didSignIn()
        case .onboarded:
            let signInCoordinator = SignInCoordinator(baseController)
            signInCoordinator.delegate = self
            signInCoordinator.start(animated: animated, completion: completion)
            childCoordinator = signInCoordinator
        case .needsOnboarding:
            let onboardCoordinator = OnboardingCoordinator(baseController)
            onboardCoordinator.delegate = self
            onboardCoordinator.start(animated: animated, completion: completion)
            childCoordinator = onboardCoordinator
        }
    }

    func cleanup(animated: Bool, completion: VoidClosure?) {
        childCoordinator?.cleanup(animated: animated, completion: completion)
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
        guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
            preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        }
        childCoordinator = nil
        onboardCoordinator.cleanup(animated: true, completion: {
            let signInCoordinator = SignInCoordinator(self.baseController)
            signInCoordinator.delegate = self
            self.childCoordinator = signInCoordinator
            // TODO - signInCoordinator move from signIn to register here
            signInCoordinator.start(animated: true, completion: nil)
        })
    }

    func didRequestSignIn() {
        guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
            preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
        }
        childCoordinator = nil
        onboardCoordinator.cleanup(animated: true, completion: {
            let signInCoordinator = SignInCoordinator(self.baseController)
            signInCoordinator.delegate = self
            self.childCoordinator = signInCoordinator
            signInCoordinator.start(animated: true, completion: nil)
        })
    }

}
