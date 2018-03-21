//
//  HomeCoordinator.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/27/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

class HomeCoordinator: Coordinator {

    func start(with presentation: (UIViewController) -> Void) {
        let nav = UINavigationController()
        attach(to: nav)
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .red
        homeVC.title = L10n.Home.title
        nav.viewControllers = [homeVC]
        presentation(nav)
    }

}
