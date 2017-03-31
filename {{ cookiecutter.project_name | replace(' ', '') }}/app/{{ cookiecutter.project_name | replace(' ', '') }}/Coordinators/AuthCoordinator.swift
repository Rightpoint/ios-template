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

class AuthCoordinator: Coordinator {

<<<<<<< HEAD
    var childCoordinator: Coordinator?
=======
    var childCoordinators = [Coordinator]()
>>>>>>> feature/nevillco/coordinators
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
<<<<<<< HEAD
            childCoordinator = signInCoordinator
=======
            childCoordinators.append(signInCoordinator)
>>>>>>> feature/nevillco/coordinators
        }
        else {
            let onboardCoordinator = OnboardingCoordinator(baseController)
            onboardCoordinator.delegate = self
            onboardCoordinator.start()
<<<<<<< HEAD
            childCoordinator = onboardCoordinator
=======
            childCoordinators.append(onboardCoordinator)
>>>>>>> feature/nevillco/coordinators
        }
    }

    func cleanup() {
<<<<<<< HEAD
        childCoordinator?.cleanup()
=======
        // This coordinator never directly presents controllers,
        // so just clean up any children.
        for child in childCoordinators {
            child.cleanup()
        }
>>>>>>> feature/nevillco/coordinators
    }

}

extension AuthCoordinator: SignInCoordinatorDelegate {

    func didSignIn() {
        delegate?.didSignIn()
    }

}

extension AuthCoordinator: OnboardingCoordinatorDelegate {

<<<<<<< HEAD
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
=======
    func didCompleteOnboarding() {
        guard let (index, onboardCoordinator) = child(ofType: OnboardingCoordinator.self) else {
            preconditionFailure("On didCompleteOnboarding, we should have an OnboardingCoordinator in our list of coordinators.")
        }
        childCoordinators.remove(at: index)
        onboardCoordinator.cleanup()
>>>>>>> feature/nevillco/coordinators

        let signInCoordinator = SignInCoordinator(baseController)
        signInCoordinator.delegate = self
        signInCoordinator.start()
<<<<<<< HEAD
        childCoordinator = signInCoordinator
    }

=======
        childCoordinators.append(signInCoordinator)
    }
>>>>>>> feature/nevillco/coordinators
}
