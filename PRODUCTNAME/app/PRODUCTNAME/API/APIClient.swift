//
//  APIClient.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

final class APIClient {
    static var shared = APIClient()

    let manager: Alamofire.SessionManager
    let oauthClient: OAuthClient
    let baseURL: URL
    let authorizationToken: String? = nil

    init(baseURL: URL = BuildType.active.baseURL, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.oauthClient = OAuthClient(baseURL: baseURL, configuration: configuration)
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        manager = SessionManager(configuration: configuration)
        manager.adapter = oauthClient
        manager.retrier = oauthClient
    }

    func request<T: Unmarshaling>(_ endpoint: APIEndpoint, completion: @escaping (T?, Error?) -> Void) {
        let request = manager.request(baseURL, endpoint: endpoint)
        let handler = APIObjectResponseSerializer(type: T.self)
        request.validate { (request, response, data) -> Request.ValidationResult in
            switch response.statusCode {
            case 401:
                return .failure(APIError.tokenExpired)
            case 400..<Int.max:
                return .failure(APIError.invalidResponse)
            default:
                return .success
            }
        }

        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
    }

    func request<T: Unmarshaling>(_ endpoint: APIEndpoint, completion: @escaping ([T]?, Error?) -> Void) {
        let request = manager.request(baseURL, endpoint: endpoint)
        request.validate { (request, response, data) -> Request.ValidationResult in
            switch response.statusCode {
            case 401:
                return .failure(APIError.tokenExpired)
            case 400..<Int.max:
                return .failure(APIError.invalidResponse)
            default:
                return .success
            }
        }
        let handler = APICollectionResponseSerializer(type: T.self)

        request.response(responseSerializer: handler) { response in
            completion(response.result.value, response.result.error)
        }
    }
}
