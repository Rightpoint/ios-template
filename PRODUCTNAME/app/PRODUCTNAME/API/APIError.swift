//
//  APIError.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Foundation

enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
}
