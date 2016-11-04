//
//  OauthEndpoint.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/2/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire
import Marshal

/// OAuthClient manages the OAuth requests. It is responsible for:
/// - the inital login which obtains the refresh token
/// - refreshing the token when it expires
/// - adding authentication token to APIClient requests
/// - retrying APIClient requests on authorization failures.
final class OAuthClient {
    var clientSecret = BuildType.active.oathClientToken
    var clientID = BuildType.active.oathClientID

    struct Credentials {
        var refreshToken: String
        var token: String
        var expirationDate: Date
    }

    var credentials: Credentials?
    fileprivate var authenticatedTriggers: [(Void) -> ()] = []
    fileprivate var authenticationRequest: DataRequest? = nil
    fileprivate let lock = NSLock()

    var isAuthenticated: Bool {
        return credentials != nil
    }

    let baseURL: URL
    let manager: Alamofire.SessionManager
    init(baseURL: URL = BuildType.active.baseURL, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        self.manager = SessionManager(configuration: configuration)
    }
}

// MARK: Request Authorization

/// The OAuthClient is a request adapter for the APIClient
extension OAuthClient: RequestAdapter {

    // Add the authorization header to the request. If there are no credentials, let the request through. It will 401 and retry.
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        lock.lock() ; defer { lock.unlock() }
        var urlRequest = urlRequest
        if let token = credentials?.token {
            urlRequest.allHTTPHeaderFields?[APIConstants.authorization] = "Bearer \(token)"
        }
        return urlRequest
    }
}

// MARK: Request Retry

/// The OAuthClient manages retries for the APIClient
extension OAuthClient: RequestRetrier {

    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        guard request.response?.statusCode == 401, isAuthenticated else {
            completion(false, 0)
            return
        }
        if authenticationRequest == nil {
            refresh() {_ in }
        }
        authenticatedTriggers.append { [unowned self] in
            completion(self.credentials != nil, 0)
        }
    }
}

// MARK: - Requests

extension OAuthClient {

    // MARK: Token Request

    struct TokenRequest {
        let clientID: String
        let clientSecret: String
        let username: String
        let password: String
    }

    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        let endpoint = TokenRequest(clientID: clientID, clientSecret: clientSecret, username: username, password: password)
        let request = manager.request(baseURL, endpoint: endpoint)
        request.responseJSON { [weak self] response in
            self?.handleOauth(response: response, completion: completion)
        }
        authenticationRequest = request
    }

    // MARK: Token Refresh

    struct RefreshRequest {
        let clientID: String
        let clientSecret: String
        let refreshToken: String
    }

    func refresh(completion: @escaping (Error?) -> Void) {
        guard let credentials = credentials else {
            completion(APIError.invalidCredentials)
            return
        }
        let endpoint = RefreshRequest(clientID: clientID, clientSecret: clientSecret, refreshToken: credentials.refreshToken)
        let request = manager.request(baseURL, endpoint: endpoint)
        request.responseJSON { [weak self] response in
            self?.handleOauth(response: response, completion: completion)
        }
        authenticationRequest = request
    }

    func handleOauth(response: DataResponse<Any>, completion: @escaping (Error?) -> Void) {
        lock.lock() ; defer { lock.unlock() }
        var credentials: Credentials? = nil
        var error = response.result.error
        if let value = response.result.value as? MarshalDictionary {
            do {
                credentials = try Credentials(object: value)
            }
            catch let encodeError {
                error = encodeError
            }
        }
        self.credentials = credentials
        let triggers = authenticatedTriggers
        authenticatedTriggers = []
        for trigger in triggers {
            trigger()
        }
        completion(error)
        authenticationRequest = nil
    }
}

// MARK: - Encoding

extension OAuthClient.TokenRequest: APIEndpoint {
    var path: String { return "oauth/token" }
    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var requiresAuth: Bool { return true }

    var parameters: JSONObject? {
        return [
            "username": username,
            "password": password,
            APIConstants.grantType: "password",
            APIConstants.clientID: clientID,
            APIConstants.clientSecret: clientSecret,
        ]
    }

    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            APIConstants.authorization: "Basic \(clientSecret)",
        ]
    }
}

extension OAuthClient.RefreshRequest: APIEndpoint {
    var path: String { return "oauth/refresh" }
    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var requiresAuth: Bool { return true }

    var parameters: JSONObject? {
        return [
            "refreshToken": refreshToken,
            APIConstants.grantType: "refresh_token",
            APIConstants.clientID: clientID,
            APIConstants.clientSecret: clientSecret,
        ]
    }

    var headers: HTTPHeaders {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}

extension OAuthClient.Credentials: Unmarshaling {
    init(object json: MarshaledObject) throws {
        refreshToken = try json.value(for: "refreshToken")
        token = try json.value(for: "token")
        expirationDate = try json.value(for: "expirationDate")
    }
}
