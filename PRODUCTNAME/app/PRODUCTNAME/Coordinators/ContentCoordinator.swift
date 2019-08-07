//
//  ContentCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

class ContentCoordinator: NSObject, Coordinator {

    let baseController: UINavigationController
    var childCoordinator: Coordinator?

    init(_ baseController: UINavigationController) {
        self.baseController = baseController
        super.init()
    }

    func start(animated: Bool) {
        let vc = ContentTabBarViewController()
//        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = .blue
//        baseController.present(vc, animated: animated)
        baseController.pushViewController(vc, animated: animated)
    }

    func cleanup(animated: Bool) {
//        baseController.dismiss(animated: animated)
        baseController.popViewController(animated: animated)
    }

}
