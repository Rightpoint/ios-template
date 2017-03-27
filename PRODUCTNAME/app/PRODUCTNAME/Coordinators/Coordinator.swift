//
//  Coordinator.swift
//  PRODUCTNAME
//
//  Created by Connor Neville on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import UIKit

protocol Coordinator {

    var baseController: UIViewController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()

}

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
