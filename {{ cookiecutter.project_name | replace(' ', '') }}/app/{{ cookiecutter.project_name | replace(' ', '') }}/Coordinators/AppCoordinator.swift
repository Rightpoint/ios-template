//
//  AppCoordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start(with presentation: (UIViewController) -> Void) {
        guard OnboardingCoordinator.hasOnboarded else {
            let onboardingCoordinator = OnboardingCoordinator()
            onboardingCoordinator.delegate = self
            attach(to: onboardingCoordinator)
            onboardingCoordinator.start(with: presentation)
            return
        }

        let authCoordinator = AuthCoordinator()
        guard authCoordinator.isAuthenticated else {
            authCoordinator.delegate = self
            attach(to: authCoordinator)
            authCoordinator.startSignIn(with: presentation)
            return
        }

        let homeCoordinator = HomeCoordinator()
        attach(to: homeCoordinator)
        homeCoordinator.start(with: presentation)
    }

}

extension AppCoordinator: OnboardingCoordinator.Delegate {

    func onboardingCoordinator(_ coordinator: OnboardingCoordinator, didNotify action: OnboardingCoordinator.Action) {
        switch action {
        case .skip:
            let homeCoordinator = HomeCoordinator()
            attach(to: homeCoordinator)
            homeCoordinator.start {
                window.setRootViewController($0, animated: true)
            }

        case .join:
            let authCoordinator = AuthCoordinator()
            attach(to: authCoordinator)
            authCoordinator.startSignUp {
                window.rootViewController?.present($0, animated: true, completion: nil)
            }

        case .signIn:
            let authCoordinator = AuthCoordinator()
            attach(to: authCoordinator)
            authCoordinator.startSignIn {
                window.rootViewController?.present($0, animated: true, completion: nil)
            }

        }
    }

}

extension AppCoordinator: AuthCoordinator.Delegate {

    func authCoordinator(_ coordinator: AuthCoordinator, didNotify action: AuthCoordinator.Action) {
        switch action {
        case .signedIn:
            let homeCoordinator = HomeCoordinator()
            attach(to: homeCoordinator)
            homeCoordinator.start {
                window.setRootViewController($0, animated: true)
            }
        }
    }

}
