//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol OnboardingCoordinatorDelegate: class {

    func didSkipAuth()
    func didRequestJoin()
    func didRequestSignIn()

}

class OnboardingCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinator: Coordinator?
    weak var delegate: OnboardingCoordinatorDelegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start(animated: Bool, completion: (() -> Void)?) {
        let vc = OnboardingPageViewController()
        vc.delegate = self
        // Wrapped in dispatch block to ensure this happens on the next run loop
        // after the root is configured, to prevent "Unbalanced calls to begin/
        // "end appearance transitions" warning. Necessary for any controllers
        // presented directly off of the root controller.
        DispatchQueue.main.async {
            self.baseController.present(vc, animated: animated, completion: completion)
        }
    }

    func cleanup(animated: Bool, completion: (() -> Void)?) {
        baseController.dismiss(animated: animated, completion: completion)
    }

}

extension OnboardingCoordinator: OnboardingPageViewControllerDelegate {

    func skipTapped(for controller: OnboardingPageViewController) {
        delegate?.didSkipAuth()
    }

    func joinTapped(for controller: OnboardingPageViewController) {
        delegate?.didRequestJoin()
    }

    func signInTapped(for controller: OnboardingPageViewController) {
        delegate?.didRequestSignIn()
    }

}
