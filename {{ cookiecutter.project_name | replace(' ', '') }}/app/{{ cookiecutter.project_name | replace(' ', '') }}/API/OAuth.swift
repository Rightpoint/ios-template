//
//  OauthEndpoint.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/2/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire
import Marshal
import KeychainAccess

/// OAuthClient manages the OAuth requests. It is responsible for:
/// - the inital login which obtains the refresh token.
/// - refreshing the token when it expires.
/// - adding authentication token to APIClient requests.
/// - retrying APIClient requests on authorization failures.
/// - post notification when credentials are lost.
final class OAuthClient {
    static let credentials = "credentials"

    /// validKeychain indicates that the value in the keychain is from this installation
    /// This is used so the credentials from a previous installation are not re-used.
    static var validKeychain: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "validCredentials")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "validCredentials")
        }
    }

    var clientSecret = BuildType.active.oathClientToken
    var clientID = BuildType.active.oathClientID
    let keychain: Keychain

    struct Credentials {
        var refreshToken: String
        var accessToken: String
        var expirationDate: Date
    }

    var credentials: Credentials? {
        didSet {
            if let credentials = credentials {
                _ = try? keychain.set(credentials, key: OAuthClient.credentials)
            }
            else {
                _ = try? keychain.remove(OAuthClient.credentials)
            }
            // If there were credentials, and there no longer are, post a notification
            if oldValue != nil && credentials == nil {
                NSLog("OAuth Lost Authentication")
                NotificationCenter.default.post(name: .OAuthLostAuthentication, object: self)
            }
        }
    }
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
        self.keychain = Keychain(service: BuildType.active.identifier(suffix: OAuthClient.credentials))

        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        self.manager = SessionManager(configuration: configuration)

        if let credentials: Credentials? = try? keychain.getObject(OAuthClient.credentials) {
            if OAuthClient.validKeychain {
                self.credentials = credentials
            }
            else {
                self.credentials = nil
            }
        }
        OAuthClient.validKeychain = true
    }
}

// MARK: Request Authorization

/// The OAuthClient is a request adapter for the APIClient
extension OAuthClient: RequestAdapter {

    // Add the authorization header to the request. If there are no credentials, let the request through. It will 401 and retry.
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        lock.lock() ; defer { lock.unlock() }
        var urlRequest = urlRequest
        if let token = credentials?.accessToken {
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
        let statusCode = request.response?.statusCode
        let shouldRetry = statusCode == 401 && isAuthenticated
        if shouldRetry {
            NSLog("Retrying failed request")
        }
        else {
            var info: [String] = []
            if !isAuthenticated {
                info.append("Client not authenticated")
            }
            if statusCode != 401 {
                info.append("Status code is not 401")
            }
            NSLog("Fail request: \(info.flatMap { $0 }.joined(separator: ", "))")
        }
        guard shouldRetry else {
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
        let request = manager.request(baseURL, endpoint: endpoint) { [weak self] (credentials, error) in
            self?.handleOauth(credentials: credentials)
            completion(error)
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
        let request = manager.request(baseURL, endpoint: endpoint) { [weak self] (credentials, error) in
            self?.handleOauth(credentials: credentials)
            completion(error)
        }
        authenticationRequest = request
    }

    func handleOauth(credentials: Credentials?) {
        lock.lock() ; defer { lock.unlock() }
        self.credentials = credentials
        let triggers = authenticatedTriggers
        authenticatedTriggers = []
        for trigger in triggers {
            trigger()
        }
        authenticationRequest = nil
    }
}

// MARK: - Encoding

extension OAuthClient.TokenRequest: APIEndpoint {
    typealias ResponseType = OAuthClient.Credentials
    var path: String { return "oauth/token" }
    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return URLEncoding.default }

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
            APIConstants.contentType: APIConstants.formEncoded,
            APIConstants.authorization: "Basic \(clientSecret)",
        ]
    }
}

extension OAuthClient.RefreshRequest: APIEndpoint {
    typealias ResponseType = OAuthClient.Credentials

    var path: String { return "oauth/refresh" }
    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return URLEncoding.default }

    var parameters: JSONObject? {
        return [
            "refreshToken": refreshToken,
            APIConstants.grantType: "refresh_token",
            APIConstants.clientID: clientID,
            APIConstants.clientSecret: clientSecret,
        ]
    }

    var headers: HTTPHeaders {
        return [APIConstants.contentType: APIConstants.formEncoded]
    }
}

extension OAuthClient.Credentials: Unmarshaling {
    init(object json: MarshaledObject) throws {
        refreshToken = try json.value(for: "refreshToken")
        accessToken = try json.value(for: "token")
        expirationDate = try json.value(for: "expirationDate")
    }
}

extension OAuthClient.Credentials: Marshaling {
    func marshaled() -> [String: Any] {
        return [
            "refreshToken": refreshToken,
            "token": accessToken,
            "expirationDate": Formatters.ISODateFormatter.string(from: expirationDate),
        ]
    }
}

extension NSNotification.Name {

    /// This notification is posted whenever the OAuthClient has a refreshToken and lost it (ie: it attempted to refresh the token and failed)
    public static let OAuthLostAuthentication: NSNotification.Name = NSNotification.Name(rawValue: BuildType.active.identifier(suffix: "OauthLostAuthentication"))
}
