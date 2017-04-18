//
//  APIError.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
    case server
}
