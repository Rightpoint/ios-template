//
//  ContentCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

class ContentCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinator: Coordinator?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start(animated: Bool, completion: VoidClosure?) {
        // TODO - create and use ContentViewController
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        // Wrapped in dispatch block to ensure this happens on the next run loop
        // after the root is configured, to prevent "Unbalanced calls to begin/
        // "end appearance transitions" warning. Necessary for any controllers
        // presented directly off of the root controller.
        DispatchQueue.main.async {
            self.baseController.present(vc, animated: animated, completion: completion)
        }
    }

    func cleanup(animated: Bool, completion: VoidClosure?) {
        baseController.dismiss(animated: animated, completion: completion)
    }

}
