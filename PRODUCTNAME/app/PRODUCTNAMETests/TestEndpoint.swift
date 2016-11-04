//
//  RandomEndpoint.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/3/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal
@testable import PRODUCTNAME

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
