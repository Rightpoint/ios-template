//
//  APIError.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

public enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
    case server(statusCode: Int)
    case noData
}

public enum PRODUCTNAMEError: Error, Decodable {
    case unknown([String: Any])
    case example(ExampleError)

    enum CodingKeys: String, CodingKey {
        case errors
    }

    public enum ExampleError: String, Error, Decodable {
        case notFound = "Not found."
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let exampleError = try container.decode(ExampleError.self, forKey: .errors)
        self = .example(exampleError)
    }
}
