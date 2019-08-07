//
//  AuthCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

private enum State {

    case authenticated
    case onboarded
    case needsOnboarding

}

class AuthCoordinator: NSObject, Coordinator {

    var childCoordinator: Coordinator?
    let baseController: UINavigationController
    weak var delegate: Delegate?

    private let client = APIClient.shared
    private var state: State {
        if client.oauthClient.isAuthenticated {
            return .authenticated
        } else if UserDefaults.hasOnboarded {
            return .onboarded
        } else {
            return .needsOnboarding
        }
    }

    init(_ baseController: UINavigationController) {
        self.baseController = baseController
        super.init()
    }

    func start(animated: Bool) {
        switch state {
        case .authenticated:
            notify(.didSignIn)
        case .onboarded:
            let signInCoordinator = SignInCoordinator(baseController)
            signInCoordinator.delegate = self
            signInCoordinator.start(animated: animated)
            childCoordinator = signInCoordinator
        case .needsOnboarding:
            let onboardCoordinator = OnboardingCoordinator(baseController)
            onboardCoordinator.delegate = self
            onboardCoordinator.start(animated: animated)
            childCoordinator = onboardCoordinator
        }
    }

    func cleanup(animated: Bool) {
        childCoordinator?.cleanup(animated: animated)
    }

    func replaceChild(with newChild: Coordinator) {
        var navControllers = baseController.viewControllers
        
        let signInCoordinator = SignInCoordinator(self.baseController)
        signInCoordinator.delegate = self



        onboardCoordinator.cleanup(animated: false)

        self.childCoordinator = signInCoordinator
        signInCoordinator.start(animated: true)
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
            onboardCoordinator.cleanup(animated: false)
            let signInCoordinator = SignInCoordinator(self.baseController)
            signInCoordinator.delegate = self
            self.childCoordinator = signInCoordinator
            // TODO - signInCoordinator move from signIn to register here
            signInCoordinator.start(animated: true)

        case .didRequestSignIn:
            guard let onboardCoordinator = childCoordinator as? OnboardingCoordinator else {
                preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
            }
            childCoordinator = nil
            onboardCoordinator.cleanup(animated: false)
            let signInCoordinator = SignInCoordinator(self.baseController)
            signInCoordinator.delegate = self
            self.childCoordinator = signInCoordinator
            signInCoordinator.start(animated: true)
        }
    }

}
