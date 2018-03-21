//
//  AuthCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class AuthCoordinator: Coordinator {

    weak var delegate: Delegate?

    var isAuthenticated: Bool {
        // TODO: inject and check from services
        return false
    }

    func startSignIn(with presentation: (UIViewController) -> Void) {
        let nav = UINavigationController()
        attach(to: nav)

        let signInViewController = UIViewController()
        signInViewController.view.backgroundColor = .yellow
        signInViewController.title = L10n.Signin.title
        nav.viewControllers = [signInViewController]
        presentation(nav)
    }

    func startSignUp(with presentation: (UIViewController) -> Void) {
        let nav = UINavigationController()
        attach(to: nav)

        let signUpViewController = UIViewController()
        signUpViewController.view.backgroundColor = .orange
        signUpViewController.title = L10n.Signup.title
        nav.viewControllers = [signUpViewController]
        presentation(nav)
    }

}

extension AuthCoordinator: Actionable {

    enum Action {
        case signedIn
    }

}
