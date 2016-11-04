//
//  APIEndpoint.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

protocol APIEndpoint {

    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var requiresAuth: Bool { get }
    var parameters: JSONObject? { get }
    var headers: HTTPHeaders { get }

}
