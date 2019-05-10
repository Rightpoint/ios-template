//
//  Payloads.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/3/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Foundation
@testable import PRODUCTNAME
import Services

enum Payloads {
    static let oauth: Data = {
        let json = [
            "refresh_token": "FAKE_REFRESH_TOKEN",
            "access_token": "FAKE_TOKEN",
            "expires_in": "3600",
        ]
        do {
            return try JSONSerialization.data(withJSONObject: json)
        }
        catch {
            return Data()
        }
    }()

    static let test: Data = {
        let json = [
            [
                "value": "FAKE_VALUE",
            ],
        ]
        do {
            return try JSONSerialization.data(withJSONObject: json)
        }
        catch {
            return Data()
        }
    }()

}
