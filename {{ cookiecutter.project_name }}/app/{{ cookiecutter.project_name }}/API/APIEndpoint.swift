//
//  APIEndpoint.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire

protocol APIEndpoint {

    /// The HTTP method to use (e.g. "GET").
    var method: Alamofire.Method { get }

    /// The endpoint's path, relative to the base URL.
    var path: String { get }

    /// The encoding to use (e.g. "application/json") for any request parameters.
    var encoding: Alamofire.ParameterEncoding { get }

    /// The parameters to encode
    var parameters: [String : AnyObject]? { get }

}
