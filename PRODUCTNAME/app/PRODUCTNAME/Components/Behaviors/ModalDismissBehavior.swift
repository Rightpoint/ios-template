//
//  ModalDismissBehavior.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Swiftilities

final class ModalDismissBehavior: ViewControllerLifecycleBehavior {

    fileprivate weak var viewController: UIViewController?

    func beforeAppearing(_ viewController: UIViewController, animated: Bool) {
        self.viewController = viewController
        self.viewController?.navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissButtonTapped))
    }

    @objc func dismissButtonTapped() {
        viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
