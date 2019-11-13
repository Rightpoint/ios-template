//
//  Coordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit
import Services

protocol Coordinator {

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
    func start(animated: Bool, completion: VoidClosure?)

    /// Clean up after this coordinator. Should get the app back to the
    /// state it was in when this coordinator started.
    ///
    /// - Parameters:
    ///   - animated: whether to animate any transitions.
    ///   - completion: a completion block.
    func cleanup(animated: Bool, completion: VoidClosure?)

}
