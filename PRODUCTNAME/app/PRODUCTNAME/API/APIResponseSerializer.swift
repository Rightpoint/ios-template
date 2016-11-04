//
//  APIResponseSerializer.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

// Implement DataResponseSerializerProtocol struct, or create a function to return a configured DataResponseSerializer
// Add a Request extension to ensure it is used

func APIObjectResponseSerializer<T: Unmarshaling>(type: T.Type) -> DataResponseSerializer<T> {
    return DataResponseSerializer() { request, response, data, error in
        do {
            if let error = error { throw error }

            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let object = JSON as? JSONObject else {
                throw APIError.invalidResponse
            }

            return try .success(type.init(object: object))
        }
        catch {
            return .failure(error as NSError)
        }
    }
}

func APICollectionResponseSerializer<T: Unmarshaling>(type: T.Type) -> DataResponseSerializer<[T]> {
    return DataResponseSerializer() { request, response, data, error in
        do {
            if let error = error { throw error }

            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let collection = JSON as? [JSONObject] else {
                throw APIError.invalidResponse
            }

            return try .success(collection.map { try type.init(object: $0) })
        }
        catch {
            return .failure(error as NSError)
        }
    }
}
