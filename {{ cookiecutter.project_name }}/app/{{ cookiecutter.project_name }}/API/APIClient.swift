//
//  APIClient.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire

final class APIClient {
    static var shared = APIClient()
    let manager: Alamofire.SessionManager

    init(configuration: URLSessionConfiguration = .default) {
        configuration.configureHeadersForAPI()
        self.manager = SessionManager(configuration: configuration)
    }
}

private extension URLSessionConfiguration {

    func configureHeadersForAPI() {
        var headers = httpAdditionalHeaders ?? [:]

        headers["Accept"] = "application/json"

        httpAdditionalHeaders = headers
    }

}

extension APIClient: RequestAdapter {

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        var urlRequest = urlRequest

        // Add authentication headers
        // Change the hostname

        return urlRequest
    }

}

extension APIClient: RequestRetrier {

    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        guard request.response?.statusCode == 401 else {
            completion(false, 0)
            return
        }
        // Perform retry and call completion
        completion(false, 0)
    }

}
