//
//  SignInViewController.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import UIKit
import Anchorage
import AuthenticationServices

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        // add sign in with apple if available
        if #available(iOS 13.0, *) {
            let button = ASAuthorizationAppleIDButton()
            button.addTarget(self, action: #selector(handleAuthorizationButtonPress), for: .touchUpInside)
            view.addSubview(button)
            button.centerAnchors == view.centerAnchors
            button.widthAnchor == view.widthAnchor - 40.0
        }
    }

    @available(iOS 13.0, *)
    @objc func handleAuthorizationButtonPress() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

@available(iOS 13.0, *)
extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller _: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let identityToken = credential.identityToken
//            let userIdentifier = credential.user
//            let authCode = credential.authorizationCode
//            let realUserStatus = credential.realUserStatus
            print("User Name: \(String(describing: credential.fullName))")
        }
        // Create account in your system
    }

    func authorizationController(controller _: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        // Handle error
    }
}

@available(iOS 13.0, *)
extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
