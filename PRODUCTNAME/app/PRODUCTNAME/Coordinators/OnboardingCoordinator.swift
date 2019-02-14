//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/27/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Actionable
import UIKit
import Services

class OnboardingCoordinator: Coordinator {

    let baseController: UIViewController
    var childCoordinator: Coordinator?
    weak var delegate: Delegate?

    init(_ baseController: UIViewController) {
        self.baseController = baseController
    }

    func start(animated: Bool, completion: VoidClosure?) {
        let vc = OnboardingPageViewController(
            viewModels: OnboardingCoordinator.pageViewModels)
        vc.delegate = self
        baseController.present(vc, animated: animated, completion: completion)
    }

    func cleanup(animated: Bool, completion: VoidClosure?) {
        baseController.dismiss(animated: animated, completion: completion)
    }

}

extension OnboardingCoordinator: Actionable {

    enum Action {
        case didSkipAuth
        case didRequestJoin
        case didRequestSignIn
    }

}

extension OnboardingCoordinator: OnboardingPageViewControllerDelegate {

    func onboardingPageViewController(_ vc: OnboardingPageViewController, didNotify action: OnboardingPageViewController.Action) {
        switch action {
        case .skipTapped:
            notify(.didSkipAuth)
        case .joinTapped:
            notify(.didRequestJoin)
        case .signInTapped:
            notify(.didRequestSignIn)
        }
    }

}

extension OnboardingCoordinator {

    static var pageViewModels: [OnboardingSamplePageViewModel] {
        let samplePage = OnboardingSamplePageViewModel(
            header: L10n.Onboarding.Pages.Sample.heading,
            body: L10n.Onboarding.Pages.Sample.body,
            asset: Asset.logoKennyLoggins
        )
        return [samplePage, samplePage, samplePage]
    }

}
