//
//  Coordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

protocol Coordinator: class, NSObjectProtocol {

    /// A child coordinator spun off by this coordinator.
    /// Important to keep a reference to prevent deallocation.
    var childCoordinator: Coordinator? { get set }

    /// Start any action this coordinator should take. Often, this is
    /// presenting/pushing a new controller, or starting up a
    /// child coordinator.
    ///
    /// - Parameters:
    ///   - animated: whether to animate any transitions.
    ///   - completion: a completion block.
    func start(animated: Bool)

    /// Clean up after this coordinator. Should get the app back to the
    /// state it was in when this coordinator started.
    ///
    /// - Parameters:
    ///   - animated: whether to animate any transitions.
    ///   - completion: a completion block.
    func cleanup(animated: Bool)

}

/// Parent Coordinator should hold a reference to each child coordinator
protocol NewCoordinator: class, NSObjectProtocol {
    /// The entry point for this UX flow.
    var rootViewController: UIViewController { get }
    var parentCoordinator: CoordinatorDelegate { get set }

    init(with parentCoord: NewCoordinator)
}

protocol CoordinatorDelegate {
    func coordinatorShouldDismiss(_ childCoord: NewCoordinator)
}

//protocol NavCoordinator: Coordinator {
//    var baseController: UINavigationController { get }
//
//    func presentChild(_ coordinator: Coordinator, animated: Bool)
//}
//
//extension NavCoordinator {
//    func presentChild(_ coordinator: Coordinator, animated: Bool) {
//        switch animated {
//        case true:
//            coordinator
//            baseController.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: animated)
//        case false:
//            <#code#>
//        }
//
//    }
//}
