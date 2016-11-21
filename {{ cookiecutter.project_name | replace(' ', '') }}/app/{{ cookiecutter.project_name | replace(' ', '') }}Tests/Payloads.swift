//
//  Payloads.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation
@testable import {{ cookiecutter.project_name }}

enum Payloads {
    static let oauth: Data = {
        let json = [
            "refreshToken": "FAKE_REFRESH_TOKEN",
            "token": "FAKE_TOKEN",
            "expirationDate": Formatters.ISODateFormatter.string(from: Date.distantFuture),
            ]
        return try! JSONSerialization.data(withJSONObject: json)
    }()

    static let test: Data = {
        let json = [[
            "value": "FAKE_VALUE",
            ]]
        return try! JSONSerialization.data(withJSONObject: json)
    }()

}
