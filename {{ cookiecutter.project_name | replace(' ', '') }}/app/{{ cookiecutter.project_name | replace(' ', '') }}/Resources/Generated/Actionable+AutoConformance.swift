// Generated using Sourcery 0.12.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



//swiftlint:disable:previous vertical_whitespace

// MARK: - AuthCoordinator
protocol AuthCoordinatorDelegate: class {
    func authCoordinator(_ coordinator: AuthCoordinator, didNotify action: AuthCoordinator.Action)
}

extension AuthCoordinator {

    typealias ActionType = Action
    typealias Delegate = AuthCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.authCoordinator(self, didNotify: action)
    }

}

// MARK: - OnboardingCoordinator
protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinator(_ coordinator: OnboardingCoordinator, didNotify action: OnboardingCoordinator.Action)
}

extension OnboardingCoordinator {

    typealias ActionType = Action
    typealias Delegate = OnboardingCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.onboardingCoordinator(self, didNotify: action)
    }

}

// MARK: - OnboardingPageViewController
protocol OnboardingPageViewControllerDelegate: class {
    func onboardingPageViewController(_ vc: OnboardingPageViewController, didNotify action: OnboardingPageViewController.Action)
}

extension OnboardingPageViewController {

    typealias ActionType = Action
    typealias Delegate = OnboardingPageViewControllerDelegate

    func notify(_ action: ActionType) {
        delegate?.onboardingPageViewController(self, didNotify: action)
    }

}

// MARK: - SignInCoordinator
protocol SignInCoordinatorDelegate: class {
    func signInCoordinator(_ coordinator: SignInCoordinator, didNotify action: SignInCoordinator.Action)
}

extension SignInCoordinator {

    typealias ActionType = Action
    typealias Delegate = SignInCoordinatorDelegate

    func notify(_ action: ActionType) {
        delegate?.signInCoordinator(self, didNotify: action)
    }

}
