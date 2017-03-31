//
//  Coordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/24/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

protocol Coordinator {

    /// A child coordinator spun off by this coordinator.
    /// Important to keep a reference to prevent deallocation.
    var childCoordinator: Coordinator? { get set }

    /// Start any action this coordinator should take. Often, this is
    /// presenting/pushing a new controller, or starting up a
    /// child coordinator.
    func start()

    /// Clean up after this coordinator. Should get the app back to the
    /// state it was in when this coordinator started.
    func cleanup()

}
