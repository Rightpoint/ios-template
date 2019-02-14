// Generated using Sourcery 0.12.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT







// MARK: - AuthCoordinator
internal protocol AuthCoordinatorDelegate: class {

    func authCoordinator(_ component: AuthCoordinator, didNotify action: AuthCoordinator.Action)

}

internal extension AuthCoordinator {

    typealias ActionType = Action
    typealias Delegate = AuthCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.authCoordinator(self, didNotify: action)
    }

}

// MARK: - OnboardingCoordinator
internal protocol OnboardingCoordinatorDelegate: class {

    func onboardingCoordinator(_ component: OnboardingCoordinator, didNotify action: OnboardingCoordinator.Action)

}

internal extension OnboardingCoordinator {

    typealias ActionType = Action
    typealias Delegate = OnboardingCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.onboardingCoordinator(self, didNotify: action)
    }

}

// MARK: - OnboardingPageViewController
internal protocol OnboardingPageViewControllerDelegate: class {

    func onboardingPageViewController(_ vc: OnboardingPageViewController, didNotify action: OnboardingPageViewController.Action)

}

internal extension OnboardingPageViewController {

    typealias ActionType = Action
    typealias Delegate = OnboardingPageViewControllerDelegate

    func notify(_ action: ActionType) {
        delegate?.onboardingPageViewController(self, didNotify: action)
    }

}

// MARK: - SignInCoordinator
internal protocol SignInCoordinatorDelegate: class {

    func signInCoordinator(_ component: SignInCoordinator, didNotify action: SignInCoordinator.Action)

}

internal extension SignInCoordinator {

    typealias ActionType = Action
    typealias Delegate = SignInCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.signInCoordinator(self, didNotify: action)
    }

}

