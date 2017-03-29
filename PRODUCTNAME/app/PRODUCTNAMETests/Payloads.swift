//
//  Payloads.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/3/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Foundation
@testable import PRODUCTNAME

enum Payloads {
    static let oauth: Data = {
        let json = [
            "refreshToken": "FAKE_REFRESH_TOKEN",
            "token": "FAKE_TOKEN",
            "expirationDate": Formatters.ISODateFormatter.string(from: Date.distantFuture)
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
                "value": "FAKE_VALUE"
            ]
        ]
        do {
            return try JSONSerialization.data(withJSONObject: json)
        }
        catch {
            return Data()
        }
    }()

}
