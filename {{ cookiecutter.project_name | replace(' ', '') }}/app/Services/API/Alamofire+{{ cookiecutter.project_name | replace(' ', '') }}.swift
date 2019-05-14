//
//  Alamofire.Manager+{{ cookiecutter.project_name | replace(' ', '') }}.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire

enum Payload {
    enum Empty {}
}

extension Alamofire.SessionManager {

    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint) -> DataRequest {
        let endpointURL = baseURL.appendingPathComponent(endpoint.path)
        guard
            let url: URL = {
                var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: true)
                urlComponents?.queryItems = endpoint.queryParams?.compactMap { (name, value) in
                    return URLQueryItem(name: name, value: value)
                }
                return urlComponents?.url
            }()
            else {
                fatalError("Invalid Path Specification")
        }

        let request = self.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        DispatchQueue.global().async {
            endpoint.log(request)
        }
        return request
    }

    /**
     *For ResponseType: Empty Payload*

     Perform request and optionally unwrap an error

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `Decodable`
     - completion: A closure to process the API response
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (_ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType == Payload.Empty {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(endpoint)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.error)
        }
        return request
    }

    // MARK: - Decodable

    /**
     *For ResponseType: Decodable*

     Perform request and serialize the response automatically according to your Response Type's `Decodable` conformance

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `Decodable`
     - completion: A closure to process the API response. Will not be called if user cancels request.
     - object: the decoded response object
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (_ object: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Decodable {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(endpoint)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

}
