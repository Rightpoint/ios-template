//
//  OnboardingPageViewController.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/29/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Anchorage
import Swiftilities

class OnboardingPageViewController: UIViewController {

    fileprivate let viewControllers: [UIViewController] = [
        OnboardingSamplePageViewController(),
        OnboardingSamplePageViewController(),
        OnboardingSamplePageViewController(),
    ]

    fileprivate let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localized.Onboarding.Buttons.skip, for: .normal)
        button.setTitleColor(Colors.darkGray, for: .normal)
        button.setTitleColor(Colors.darkGray.highlighted, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    fileprivate let pageController = UIPageViewController(
        transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    fileprivate let firstHairline = HairlineView(axis: .horizontal)
    fileprivate let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localized.Onboarding.Buttons.join, for: .normal)
        button.setTitleColor(Colors.green, for: .normal)
        button.setTitleColor(Colors.green.highlighted, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    fileprivate let secondHairline = HairlineView(axis: .horizontal)
    fileprivate let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localized.Onboarding.Buttons.signIn, for: .normal)
        button.setTitleColor(Colors.darkGray, for: .normal)
        button.setTitleColor(Colors.darkGray.highlighted, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }

}

private extension OnboardingPageViewController {

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(skipButton)

        pageController.setViewControllers(
            [viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageController.delegate = self
        pageController.dataSource = self
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)

        let pageControlAppearance = UIPageControl.appearance(
            whenContainedInInstancesOf: [OnboardingPageViewController.self])
        pageControlAppearance.pageIndicatorTintColor = Colors.lightGray
        pageControlAppearance.currentPageIndicatorTintColor = Colors.darkGray

        view.addSubview(firstHairline)
        view.addSubview(joinButton)
        view.addSubview(secondHairline)
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

        joinButton.centerXAnchor == view.centerXAnchor
        joinButton.topAnchor == firstHairline.bottomAnchor + Layout.joinVerticalSpace
        joinButton.bottomAnchor == secondHairline.topAnchor - Layout.joinVerticalSpace

        secondHairline.horizontalAnchors == view.horizontalAnchors

        signInButton.centerXAnchor == view.centerXAnchor
        signInButton.topAnchor == secondHairline.bottomAnchor + Layout.signInVerticalSpace
        signInButton.bottomAnchor == view.bottomAnchor - Layout.signInVerticalSpace
    }

}

extension OnboardingPageViewController: UIPageViewControllerDelegate {

}

extension OnboardingPageViewController: UIPageViewControllerDataSource {

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
