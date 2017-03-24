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
