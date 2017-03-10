//
//  APIError.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
    case server
}

// If additional information from the JSON object is of interest, do additional
// processing in API[Object|Collection]ResponseSerializer
func APIResponseValidator(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
    // Generate an error if the status code isn't acceptable. If no error is
    // returned here, the request will not be retried.
    switch response.statusCode {
        case 401:
        return .failure(APIError.invalidCredentials)
    case 400..<500:
        return .failure(APIError.invalidResponse)
    case 500..<Int.max:
        return .failure(APIError.server)
    default:
        break
    }
    return .success
}

// Response serializer to import JSON Object using Marshal and return an object
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

// Response serializer to import JSON Array using Marshal and return an array of objects
func APICollectionResponseSerializer<T: Collection>(type: T.Type) -> DataResponseSerializer<T> where T.Iterator.Element: Unmarshaling {
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
            let result = try collection.map({ try T.Iterator.Element.init(object: $0) })
            guard let typedResult = result as? T else {
                // Result is identical to T, but of type [T.Iterator.Element] which Swift can not infer correctly.
                fatalError("Unable to transfer typed arrays")
            }
            return .success(typedResult)
        }
        catch {
            return .failure(error as NSError)
        }
    }
}
