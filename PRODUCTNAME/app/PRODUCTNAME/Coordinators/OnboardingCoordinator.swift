//
//  OnboardingCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

class OnboardingCoordinator: NSObject, Coordinator {

    let baseController: UINavigationController
    var childCoordinator: Coordinator?
    weak var delegate: Delegate?

    init(_ baseController: UINavigationController) {
        self.baseController = baseController
        super.init()
    }

    func start(animated: Bool) {
        let vc = OnboardingPageViewController(
            viewModels: OnboardingCoordinator.pageViewModels)
        vc.delegate = self
//        baseController.present(vc, animated: animated)
        baseController.pushViewController(vc, animated: animated)
    }

    func cleanup(animated: Bool) {
//        baseController.dismiss(animated: animated)
        baseController.popViewController(animated: animated)
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
