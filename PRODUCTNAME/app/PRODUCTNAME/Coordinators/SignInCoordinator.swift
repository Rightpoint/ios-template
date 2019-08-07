//
//  SignInCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

class SignInCoordinator: NSObject, Coordinator {

    let baseController: UINavigationController
    var childCoordinator: Coordinator?
    weak var delegate: Delegate?

    init(_ baseController: UINavigationController) {
        self.baseController = baseController
        super.init()
    }

    func start(animated: Bool) {
        // TODO - create and use SignInViewController
        let vc = UIViewController()
        vc.view.backgroundColor = .red
//        self.baseController.present(vc, animated: animated, completion: completion)
        self.baseController.pushViewController(vc, animated: animated)
    }

    func cleanup(animated: Bool) {
//        baseController.dismiss(animated: animated)
        baseController.popViewController(animated: animated)
    }

}

extension SignInCoordinator: Actionable {

    enum Action {
        case didSignIn
    }

}
