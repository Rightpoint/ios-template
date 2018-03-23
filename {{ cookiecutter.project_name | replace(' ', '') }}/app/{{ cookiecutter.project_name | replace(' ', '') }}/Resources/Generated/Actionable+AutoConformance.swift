// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
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

// MARK: - OnboardingViewController
protocol OnboardingViewControllerDelegate: class {
    func onboardingViewController(_ vc: OnboardingViewController, didNotify action: OnboardingViewController.Action)
}

extension OnboardingViewController {

    typealias ActionType = Action
    typealias Delegate = OnboardingViewControllerDelegate

    func notify(_ action: ActionType) {
        delegate?.onboardingViewController(self, didNotify: action)
    }

}
