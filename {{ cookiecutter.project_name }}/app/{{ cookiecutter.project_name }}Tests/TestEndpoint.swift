//
//  RandomEndpoint.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire
import Marshal
@testable import {{ cookiecutter.project_name }}

struct TestEndpoint: APIEndpoint {
    var path: String { return "test" }
    var method: HTTPMethod { return .get }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var requiresAuth: Bool { return true }
    var parameters: JSONObject? { return [:] }
    var headers: HTTPHeaders { return [:] }

}
struct TestEndpointResult: Unmarshaling {

    let value: String

    init(object: MarshaledObject) throws {
        value = try object.value(for: "value")
    }
}
