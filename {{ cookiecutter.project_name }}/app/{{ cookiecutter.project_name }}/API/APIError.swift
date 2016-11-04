//
//  APIError.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation

enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
}
