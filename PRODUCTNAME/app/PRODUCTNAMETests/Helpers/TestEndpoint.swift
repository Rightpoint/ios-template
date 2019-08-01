//
//  RandomEndpoint.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Alamofire
@testable import PRODUCTNAME
import Services

struct TestEndpoint: APIEndpoint {
    typealias ResponseType = [TestEndpointResult]
    var path: String { return "test" }
    var method: HTTPMethod { return .get }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var parameters: Parameters? { return [:] }
    var headers: HTTPHeaders { return [:] }

}

struct TestEndpointResult: Codable {

    let value: String

}
