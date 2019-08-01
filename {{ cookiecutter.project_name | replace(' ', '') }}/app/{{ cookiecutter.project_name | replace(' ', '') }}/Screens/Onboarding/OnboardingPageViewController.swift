//
//  OnboardingPageViewController.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Anchorage
import Swiftilities

// MARK: OnboardingPageViewController
class OnboardingPageViewController: UIViewController {

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

    init(viewModels: [OnboardingSamplePageViewModel]) {
        self.viewControllers = viewModels.map {
            OnboardingSamplePageViewController(viewModel: $0)
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
extension OnboardingPageViewController: Actionable {

    enum Action {
        case skipTapped
        case joinTapped
        case signInTapped
    }

}

// MARK: Private
private extension OnboardingPageViewController {

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)

        pageController.setViewControllers(
            [viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageController.dataSource = self
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)

        let pageControlAppearance = UIPageControl.appearance(
            whenContainedInInstancesOf: [OnboardingPageViewController.self])
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
        skipButton.topAnchor == view.safeAreaLayoutGuide.topAnchor + Layout.skipButtonTopInset
        skipButton.trailingAnchor == view.safeAreaLayoutGuide.trailingAnchor - Layout.skipButtonTrailingInset

        pageController.view.topAnchor == skipButton.bottomAnchor + Layout.pageViewTopSpace
        pageController.view.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors

        firstHairline.topAnchor == pageController.view.bottomAnchor
        firstHairline.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors

        joinButton.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors
        joinButton.topAnchor == firstHairline.bottomAnchor + Layout.joinVerticalSpace
        joinButton.bottomAnchor == secondHairline.topAnchor - Layout.joinVerticalSpace

        secondHairline.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors

        signInButton.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors
        signInButton.topAnchor == secondHairline.bottomAnchor + Layout.signInVerticalSpace
        signInButton.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - Layout.signInVerticalSpace
    }

}

// MARK: Actions
private extension OnboardingPageViewController {
    @objc func skipTapped() {
        notify(.skipTapped)
    }

    @objc func joinTapped() {
        notify(.joinTapped)
    }

    @objc func signInTapped() {
        notify(.signInTapped)
    }

}

// MARK: UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return viewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController),
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
        return viewControllers.firstIndex(of: current) ?? 0
    }

}
