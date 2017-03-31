//
//  Coordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

protocol Coordinator {

<<<<<<< HEAD
    /// A child coordinator spun off by this coordinator.
    /// Important to keep a reference to prevent deallocation.
    var childCoordinator: Coordinator? { get set }
=======
    /// Any child coordinators spun off by this coordinator.
    /// Important to keep a reference to them to prevent deallocation,
    /// and for cleaning up after.
    var childCoordinators: [Coordinator] { get set }
>>>>>>> feature/nevillco/coordinators

    /// Start any action this coordinator should take. Often, this is
    /// presenting/pushing a new controller, or starting up a
    /// child coordinator.
    func start()

    /// Clean up after this coordinator. Should get the app back to the
    /// state it was in when this coordinator started.
    func cleanup()

}
<<<<<<< HEAD
=======

extension Coordinator {

    /// Finds the first child coordinator of a given type.
    ///
    /// - Parameter ofType: the type of coordinator to search for.
    /// - Returns: a tuple containing the index of the child,
    /// and the child itself, if one was found.
    func child<T: Coordinator>(ofType: T.Type) -> (index: Int, child: T)? {
        if let index = childCoordinators.index(where: { $0 is T }),
            let coordinator = childCoordinators.flatMap({ $0 as? T }).first {
            return (index, coordinator)
        }
        return nil
    }

}
>>>>>>> feature/nevillco/coordinators
