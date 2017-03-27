//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol OnboardingCoordinatorDelegate: class {

    func didCompleteOnboarding()

}

class OnboardingCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinators = [Coordinator]()
    weak var delegate: OnboardingCoordinatorDelegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        // TODO - launch onboarding controller
    }

    func cleanup() {
        baseController.dismiss(animated: false, completion: nil)
    }

}
