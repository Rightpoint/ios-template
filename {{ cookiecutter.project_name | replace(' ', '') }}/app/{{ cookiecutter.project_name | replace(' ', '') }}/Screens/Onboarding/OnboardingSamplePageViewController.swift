//
//  OnboardingSamplePageViewController.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Anchorage

class OnboardingSamplePageViewController: UIViewController {

    fileprivate let imageView = UIImageView()

    fileprivate let headerLabel: UILabel = {
        let label = UILabel()
        label.bonMotStyle = .title1
        label.bonMotStyle?.color = Color.darkGray
        label.textAlignment = .center
        return label
    }()

    fileprivate let bodyLabel: UILabel = {
        let label = UILabel()
        label.bonMotStyle = .title3
        label.bonMotStyle?.color = Color.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: OnboardingSamplePageViewModel) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = viewModel.asset?.image
        headerLabel.styledText = viewModel.header
        bodyLabel.styledText = viewModel.body
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }

}

private extension OnboardingSamplePageViewController {

    func configureView() {
        view.addSubview(imageView)
        view.addSubview(headerLabel)
        view.addSubview(bodyLabel)
    }

    struct Layout {
        static let sideInsets = CGFloat(38)
        static let imageTopSpace = CGFloat(42)
        static let bodyBottomSpace = CGFloat(40)
        static let headerBottomSpace = CGFloat(20)
    }

    func configureLayout() {
        imageView.topAnchor == view.topAnchor + Layout.imageTopSpace
        imageView.centerXAnchor == view.centerXAnchor

        bodyLabel.horizontalAnchors == view.horizontalAnchors + Layout.sideInsets
        bodyLabel.bottomAnchor == view.bottomAnchor - Layout.bodyBottomSpace

        headerLabel.horizontalAnchors == view.horizontalAnchors
        headerLabel.bottomAnchor == bodyLabel.topAnchor - Layout.headerBottomSpace
    }

}
