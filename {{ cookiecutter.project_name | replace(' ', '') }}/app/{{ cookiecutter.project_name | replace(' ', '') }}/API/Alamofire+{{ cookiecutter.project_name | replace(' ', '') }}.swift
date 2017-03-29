//
//  Alamofire.Manager+{{ cookiecutter.project_name | replace(' ', '') }}.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire
import Marshal

extension SessionManager {

    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint) -> DataRequest {
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

    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (Endpoint.ResponseType?, Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Unmarshaling {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(type: Endpoint.ResponseType.self)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (Endpoint.ResponseType?, Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: Unmarshaling {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APICollectionResponseSerializer(type: Endpoint.ResponseType.self)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }
}
