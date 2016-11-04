//
//  Alamofire.Manager+{{ cookiecutter.project_name }}.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
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
