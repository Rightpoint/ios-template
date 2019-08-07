//
//  AppCoordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Services

class AppCoordinator: NSObject, Coordinator {

    private let window: UIWindow
    fileprivate let rootNavController: UINavigationController
    var childCoordinator: Coordinator?
    let simpleOver = SimpleOver()

    init(window: UIWindow) {
        self.window = window
        let appViewController = UIViewController()
        appViewController.view.backgroundColor = .green
        let rootController = UINavigationController(rootViewController: appViewController)
        rootController.isNavigationBarHidden = true
        self.rootNavController = rootController
        super.init()
        self.rootNavController.delegate = self
    }

    func start(animated: Bool) {
        // Configure window/root view controller
        window.rootViewController = rootNavController

        self.window.makeKeyAndVisible()

        // Spin off auth coordinator
        let authCoordinator = AuthCoordinator(self.rootNavController)
        authCoordinator.delegate = self
        self.childCoordinator = authCoordinator
        authCoordinator.start(animated: animated)
    }

    func cleanup(animated: Bool) {
//        completion?()
    }

}

extension AppCoordinator: AuthCoordinatorDelegate {

    func authCoordinator(_ coordinator: AuthCoordinator, didNotify action: AuthCoordinator.Action) {
        switch action {
        case .didSignIn:
            guard let authCoordinator = childCoordinator as? AuthCoordinator else {
                preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
            }
            childCoordinator = nil
            authCoordinator.cleanup(animated: false)
//            {
            let contentCoordinator = ContentCoordinator(self.rootNavController)
            self.childCoordinator = contentCoordinator
            contentCoordinator.start(animated: true)
//            }
        case .didSkipAuth:
            guard let authCoordinator = childCoordinator as? AuthCoordinator else {
                preconditionFailure("Upon signing in, AppCoordinator should have an AuthCoordinator as a child.")
            }
            childCoordinator = nil
            authCoordinator.cleanup(animated: false)
//            {
            let contentCoordinator = ContentCoordinator(self.rootNavController)
            self.childCoordinator = contentCoordinator
            contentCoordinator.start(animated: true)
//            }
        }
    }

}

extension AppCoordinator: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // check for which VCs use custom transition
        simpleOver.popStyle = (operation == .pop)
        return simpleOver
    }
}

class SimpleOver: NSObject, UIViewControllerAnimatedTransitioning {

    var popStyle: Bool = false

    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.20
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        if popStyle {

            animatePop(using: transitionContext)
            return
        }

        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

        let finalFrame = transitionContext.finalFrame(for: toVC)

        let frameOffset = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        toVC.view.frame = frameOffset

        transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame = finalFrame
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }

    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {

        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

        let startFrame = transitionContext.initialFrame(for: fromVC)
        let frameOffset = startFrame.offsetBy(dx: 0, dy: startFrame.height)

        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = frameOffset
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
}
