//
//  Alamofire.Manager+PRODUCTNAME.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/3/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

public extension SessionManager {

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
        DispatchQueue.global().async {
            endpoint.log(request)
        }
        return request
    }

    // MARK: - JSON

    /**
     *For ResponseType: JSONObject*

     Perform request and execute completion block leveraging a `JSONObject`. Use this when an API response doesn't map directly to your object graph.

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` of `JSONObject`
     - completion: A closure to process the API response
     - responseObject: the response JSON as a `JSONObject`
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func requestJSON<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (_ responseObject: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIJSONObjectResponseSerializer(endpoint)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value as? Endpoint.ResponseType, response.error)
        }
        return request
    }

    // MARK: - Unmarshaling

    /**
     *For ResponseType: Unmarshaling*

     Perform request and serialize the response automatically according to your Response Type's `Unmarshaling` conformance

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `Unmarshaling`
     - completion: A closure to process the API response
     - object: the unmarhsaled response object
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (_ object: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Unmarshaling {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(endpoint)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

    /**
     *For ResponseType: [Unmarshaling]*

     Perform request and serialize the returned collection automatically according to your Response Type's `Unmarshaling` conformance

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` which is a collection of bojects conforming to `Unmarshaling`
     - completion: A closure to process the API response
     - objects: the unmarhsaled response collection
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, completion: @escaping (_ objects: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: Unmarshaling {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APICollectionResponseSerializer(endpoint)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

    // MARK: - UnmarshalingWithContext

    /**
     *For ResponseType: UnmarshalingWithContext*

     Perform request and serialize the response automatically according to your Response Type's `UnmarshalingWithContext` conformance

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `UnmarshalingWithContext`
     - completion: A closure to process the API response
     - object: the unmarhsaled response object
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, context: Endpoint.ResponseType.ContextType, completion: @escaping (_ object: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: UnmarshalingWithContext {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(endpoint, context: context)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

    /**
     *For ResponseType: [UnmarshalingWithContext]*

     Perform request and serialize the returned collection automatically according to your Response Type's `UnmarshalingWithContext` conformance

     - Parameters:
     - baseURL: The base url to apply the endpoint `path` to
     - endpoint: An `APIEndpoint` with an associated `ResponseType` which is a collection of bojects conforming to `Unmarshaling`
     - completion: A closure to process the API response
     - objects: the unmarhsaled response collection
     - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ baseURL: URL, endpoint: Endpoint, context: Endpoint.ResponseType.Iterator.Element.ContextType, completion: @escaping (_ objects: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: UnmarshalingWithContext {
        let request = self.request(baseURL, endpoint: endpoint)
        let handler = APICollectionResponseSerializer(endpoint, context: context)
        request.validate(APIResponseValidator)
        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
        return request
    }

}
