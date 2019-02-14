//
//  AuthCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Actionable
import UIKit
import Services

private enum State {

    case authenticated
    case onboarded
    case needsOnboarding

}

class AuthCoordinator: Coordinator {

    var childCoordinator: Coordinator?
    let baseController: UIViewController
    weak var delegate: Delegate?

    private let client = APIClient.shared
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
            notify(.didSignIn)
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

extension AuthCoordinator: Actionable {

    enum Action {
        case didSignIn
        case didSkipAuth
    }

}

extension AuthCoordinator: SignInCoordinatorDelegate {

    func signInCoordinator(_ coordinator: SignInCoordinator, didNotify action: SignInCoordinator.Action) {
        switch action {
        case .didSignIn:
            notify(.didSignIn)
        }
    }

}

extension AuthCoordinator: OnboardingCoordinatorDelegate {

    func onboardingCoordinator(_ coordinator: OnboardingCoordinator, didNotify action: OnboardingCoordinator.Action) {
        switch action {
        case .didSkipAuth:
            notify(.didSkipAuth)
        case .didRequestJoin:
            guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
                preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
            }
            childCoordinator = nil
            onboardCoordinator.cleanup(animated: true) {
                let signInCoordinator = SignInCoordinator(self.baseController)
                signInCoordinator.delegate = self
                self.childCoordinator = signInCoordinator
                // TODO - signInCoordinator move from signIn to register here
                signInCoordinator.start(animated: true, completion: nil)
            }
        case .didRequestSignIn:
            guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
                preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
            }
            childCoordinator = nil
            onboardCoordinator.cleanup(animated: true) {
                let signInCoordinator = SignInCoordinator(self.baseController)
                signInCoordinator.delegate = self
                self.childCoordinator = signInCoordinator
                signInCoordinator.start(animated: true, completion: nil)
            }
        }
    }

}
