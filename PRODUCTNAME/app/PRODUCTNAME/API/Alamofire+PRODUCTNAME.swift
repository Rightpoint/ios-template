//
//  Alamofire.Manager+PRODUCTNAME.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/3/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire

extension SessionManager {

    func request(_ baseURL: URL, endpoint: APIEndpoint) -> DataRequest {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            fatalError("Invalid Path Specification")
        }
        let request = self.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        return request
    }
}
