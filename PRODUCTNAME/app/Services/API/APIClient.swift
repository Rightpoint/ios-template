//
//  APIClient.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

public class APIClient {
    let manager: Alamofire.SessionManager
    public let oauthClient: OAuthClient
    let baseURL: URL
    let authorizationToken: String? = nil

    init(baseURL: URL, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.oauthClient = OAuthClient(baseURL: baseURL, configuration: configuration)
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        manager = SessionManager(configuration: configuration)
        manager.adapter = oauthClient
        manager.retrier = oauthClient
    }

// MARK: - JSON

    /**
     *For ResponseType: JSONObject*

     Perform request and execute completion block leveraging a `JSONObject`. Use this when an API response doesn't map directly to your object graph.

     - Parameters:
        - endpoint: An `APIEndpoint` with an associated `ResponseType` of `JSONObject`
        - completion: A closure to process the API response
        - responseObject: the response JSON as a `JSONObject`
        - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func requestJSON<Endpoint: APIEndpoint>(_ endpoint: Endpoint, completion: @escaping (_ responseObject: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType == JSONObject {
        return manager.requestJSON(baseURL, endpoint: endpoint, completion: completion)
    }

// MARK: - Unmarshaling

    /**
     *For ResponseType: Unmarshaling*

     Perform request and serialize the response automatically according to your Response Type's `Unmarshaling` conformance

     - Parameters:
        - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `Unmarshaling`
        - completion: A closure to process the API response
        - object: the unmarhsaled response object
        - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint, completion: @escaping (_ object: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Unmarshaling {
        return manager.request(baseURL, endpoint: endpoint, completion: completion)
    }

    /**
     *For ResponseType: [Unmarshaling]*

     Perform request and serialize the returned collection automatically according to your Response Type's `Unmarshaling` conformance

     - Parameters:
        - endpoint: An `APIEndpoint` with an associated `ResponseType` which is a collection of bojects conforming to `Unmarshaling`
        - completion: A closure to process the API response
        - objects: the unmarhsaled response collection
        - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint, completion: @escaping (_ objects: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: Unmarshaling {
        return manager.request(baseURL, endpoint: endpoint, completion: completion)
    }

// MARK: - UnmarshalingWithContext

    /**
     *For ResponseType: UnmarshalingWithContext*

     Perform request and serialize the response automatically according to your Response Type's `UnmarshalingWithContext` conformance

     - Parameters:
        - endpoint: An `APIEndpoint` with an associated `ResponseType` conforming to `UnmarshalingWithContext`
        - completion: A closure to process the API response
        - object: the unmarhsaled response object
        - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint, context: Endpoint.ResponseType.ContextType, completion: @escaping (_ object: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: UnmarshalingWithContext {
        return manager.request(baseURL, endpoint: endpoint, context: context, completion: completion)
    }

    /**
     *For ResponseType: [UnmarshalingWithContext]*

     Perform request and serialize the returned collection automatically according to your Response Type's `UnmarshalingWithContext` conformance

     - Parameters:
        - endpoint: An `APIEndpoint` with an associated `ResponseType` which is a collection of bojects conforming to `Unmarshaling`
        - completion: A closure to process the API response
        - objects: the unmarhsaled response collection
        - error: a server or serialization error

     - Returns: a `DataRequest`
     */
    @discardableResult
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint, context: Endpoint.ResponseType.Iterator.Element.ContextType, completion: @escaping (_ objects: Endpoint.ResponseType?, _ error: Error?) -> Void) -> DataRequest where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: UnmarshalingWithContext {
        return manager.request(baseURL, endpoint: endpoint, context: context, completion: completion)
    }

}
