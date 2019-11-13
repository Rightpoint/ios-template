///
//  APISerialization.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

import Alamofire
import Swiftilities

private func ResponseSerializer<T>(_ serializer: @escaping (Data) throws -> T) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, _, data, error in
        guard let data = data else {
            return .failure(error ?? APIError.noData)
        }
        if let error = error {
            do {
                let knownError = try JSONDecoder.default.decode({{ cookiecutter.project_name | replace(' ', '') }}Error.self, from: data)
                return .failure(knownError)
            } catch let decodeError {
                let string = String(data: data, encoding: .utf8)
                Log.info("Could not decode error, falling back to generic error: \(decodeError) \(String(describing: string))")
            }
            if let errorDictionary = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String: Any] {
                return .failure({{ cookiecutter.project_name | replace(' ', '') }}Error.unknown(errorDictionary))
            }
            return .failure(error)
        }
        do {
            return .success(try serializer(data))
        } catch let decodingError {
            return .failure(decodingError)
        }
    }
}

func APIObjectResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<Void> where Endpoint.ResponseType == Payload.Empty {
    return ResponseSerializer { data in
        endpoint.log(data)
    }
}

/// Response serializer to import JSON Object using JSONDecoder and return an object
func APIObjectResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<Endpoint.ResponseType> where Endpoint.ResponseType: Decodable {
    return ResponseSerializer { data in
        endpoint.log(data)
        let decoder = JSONDecoder.default
        return try decoder.decode(Endpoint.ResponseType.self, from: data)
    }
}
