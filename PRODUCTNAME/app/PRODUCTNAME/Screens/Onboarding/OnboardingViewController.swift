//
//  OnboardingViewController.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/29/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Anchorage
import Swiftilities

// MARK: OnboardingViewController
class OnboardingViewController: UIViewController {

    fileprivate let viewControllers: [UIViewController]

    fileprivate let skipButton: UIButton = {
        let button = UIButton()
        button.bonMotStyle = .body
        button.bonMotStyle?.color = Color.darkGray
        button.setTitleColor(Color.darkGray.highlighted, for: .highlighted)
        button.styledText = L10n.Onboarding.Buttons.skip
        return button
    }()
    fileprivate let pageController = UIPageViewController(
        transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    fileprivate let firstHairline = HairlineView(axis: .horizontal)
    fileprivate let joinButton: UIButton = {
        let button = UIButton()
        button.bonMotStyle = .body
        button.bonMotStyle?.color = Color.green
        button.setTitleColor(Color.green.highlighted, for: .highlighted)
        button.styledText = L10n.Onboarding.Buttons.join
        return button
    }()
    fileprivate let secondHairline = HairlineView(axis: .horizontal)
    fileprivate let signInButton: UIButton = {
        let button = UIButton()
        button.bonMotStyle = .body
        button.bonMotStyle?.color = Color.darkGray
        button.styledText = L10n.Onboarding.Buttons.signIn
        button.setTitleColor(Color.darkGray.highlighted, for: .highlighted)
        return button
    }()
    weak var delegate: Delegate?

    init() {
        let samplePage = OnboardingSamplePageViewModel(
            header: L10n.Onboarding.Pages.Sample.heading,
            body: L10n.Onboarding.Pages.Sample.body,
            asset: Asset.logoKennyLoggins
        )
        let viewModels = [samplePage, samplePage, samplePage]

        self.viewControllers = viewModels.map {
            let vc = OnboardingSamplePageViewController()
            vc.imageView.image = $0.asset?.image
            vc.headerLabel.styledText = $0.header
            vc.bodyLabel.styledText = $0.body
            return vc
        }

        super.init(nibName: nil, bundle: nil)
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

// MARK: Actionable
extension OnboardingViewController: Actionable {

    enum Action {
        case skip
        case join
        case signIn
    }

}

// MARK: Private
private extension OnboardingViewController {

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)

        pageController.setViewControllers(
            [viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageController.dataSource = self
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)

        let pageControlAppearance = UIPageControl.appearance(
            whenContainedInInstancesOf: [OnboardingViewController.self])
        pageControlAppearance.pageIndicatorTintColor = Color.lightGray
        pageControlAppearance.currentPageIndicatorTintColor = Color.darkGray

        view.addSubview(firstHairline)
        joinButton.addTarget(self, action: #selector(joinTapped), for: .touchUpInside)
        view.addSubview(joinButton)
        view.addSubview(secondHairline)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        view.addSubview(signInButton)
    }

    struct Layout {
        static let skipButtonTrailingInset = CGFloat(20)
        static let skipButtonTopInset = CGFloat(22)
        static let pageViewTopSpace = CGFloat(20)
        static let joinVerticalSpace = CGFloat(8)
        static let signInVerticalSpace = CGFloat(18)
    }

    func configureLayout() {
        skipButton.topAnchor == view.topAnchor + Layout.skipButtonTopInset
        skipButton.trailingAnchor == view.trailingAnchor - Layout.skipButtonTrailingInset

        pageController.view.topAnchor == skipButton.bottomAnchor + Layout.pageViewTopSpace
        pageController.view.horizontalAnchors == view.horizontalAnchors

        firstHairline.topAnchor == pageController.view.bottomAnchor
        firstHairline.horizontalAnchors == view.horizontalAnchors

        joinButton.horizontalAnchors == view.horizontalAnchors
        joinButton.topAnchor == firstHairline.bottomAnchor + Layout.joinVerticalSpace
        joinButton.bottomAnchor == secondHairline.topAnchor - Layout.joinVerticalSpace

        secondHairline.horizontalAnchors == view.horizontalAnchors

        signInButton.horizontalAnchors == view.horizontalAnchors
        signInButton.topAnchor == secondHairline.bottomAnchor + Layout.signInVerticalSpace
        signInButton.bottomAnchor == view.bottomAnchor - Layout.signInVerticalSpace
    }

}

// MARK: Actions
private extension OnboardingViewController {
    @objc func skipTapped() {
        notify(.skip)
    }

    @objc func joinTapped() {
        notify(.join)
    }

    @objc func signInTapped() {
        notify(.signIn)
    }

}

// MARK: UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.index(of: viewController), index > 0 else {
            return nil
        }
        return viewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.index(of: viewController),
            index < viewControllers.count - 1 else {
            return nil
        }
        return viewControllers[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let current = pageViewController.viewControllers?.first else {
            return 0
        }
        return viewControllers.index(of: current) ?? 0
    }

}
