//
//  APIValidation.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Alamofire

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
        return .failure(APIError.server(statusCode: response.statusCode))
    default:
        break
    }
    return .success
}
