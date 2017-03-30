//
//  OnboardingSamplePageViewController.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 3/29/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Anchorage

class OnboardingSamplePageViewController: UIViewController {

    fileprivate let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = Colors.darkGray
        label.textAlignment = .center
        label.text = Localized.Onboarding.Pages.Sample.heading
        return label
    }()

    fileprivate let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Colors.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Localized.Onboarding.Pages.Sample.body
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }

}

private extension OnboardingSamplePageViewController {

    func configureView() {
        view.addSubview(headerLabel)
        view.addSubview(bodyLabel)
    }

    struct Layout {
        static let sideInsets = CGFloat(38)
        static let bodyBottomSpace = CGFloat(40)
        static let headerBottomSpace = CGFloat(20)
    }

    func configureLayout() {
        bodyLabel.horizontalAnchors == view.horizontalAnchors + Layout.sideInsets
        bodyLabel.bottomAnchor == view.bottomAnchor - Layout.bodyBottomSpace

        headerLabel.horizontalAnchors == view.horizontalAnchors
        headerLabel.bottomAnchor == bodyLabel.topAnchor - Layout.headerBottomSpace
    }

}
