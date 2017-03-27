//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinators = [Coordinator]()

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start() {
        // TODO - launch onboarding controller
    }

}
