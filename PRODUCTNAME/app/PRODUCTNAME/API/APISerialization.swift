///
//  APISerialization.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 4/16/17.
//
//

import Alamofire
import Marshal

private func ResponseSerializer<T>(_ serializer: @escaping (Data) throws -> T) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, _, data, error in
        do {
            if let error = error { throw error }
            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            return .success(try serializer(validData))
        }
        catch {
            return .failure(error as NSError)
        }
    }
}

private func ResponseSerializerAllowingOptional<T>(_ serializer: @escaping (Data) throws -> T) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, _, data, error in
        do {
            if let error = error { throw error }
            guard let validData = data, validData.count >= 0 else {
                throw APIError.invalidResponse
            }
            return .success(try serializer(validData))
        }
        catch {
            return .failure(error as NSError)
        }
    }
}

/// Response serializer to unwrap data to a JSON Object
func APIJSONObjectResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<JSONObject> {
    return ResponseSerializer { data in
        let json = try JSONParser.JSONObjectWithData(data)
        endpoint.log(json)
        return json
    }
}

/// Response serializer to unwrap data to a JSON Collection
func APIJSONCollectionResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<[JSONObject]> {
    return ResponseSerializer { data in
        let json = try JSONParser.JSONArrayWithData(data)
        endpoint.log(json)
        return json
    }
}

/// Response serializer to import JSON Object using Marshal and return an object
func APIObjectResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<Endpoint.ResponseType> where Endpoint.ResponseType: Unmarshaling {
    return ResponseSerializer { data in
        let json = try JSONParser.JSONObjectWithData(data)
        endpoint.log(json)
        return try Endpoint.ResponseType.init(object: json)
    }
}

/// Response serializer to import JSON Array using Marshal and return an array of objects
func APICollectionResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint) -> DataResponseSerializer<Endpoint.ResponseType> where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: Unmarshaling {
    return ResponseSerializer { data in
        let jsonArray = try JSONParser.JSONArrayWithData(data)
        endpoint.log(jsonArray)
        let result = try jsonArray.map({ try Endpoint.ResponseType.Iterator.Element.init(object: $0) })
        guard let typedResult = result as? Endpoint.ResponseType else {
            // Result is identical to T, but of type [T.Iterator.Element] which Swift can not infer correctly.
            fatalError("Unable to transfer typed arrays")
        }
        return typedResult
    }
}

/// Response serializer to import JSON Object using Marshal and return a managed object
func APIObjectResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint, context: Endpoint.ResponseType.ContextType) -> DataResponseSerializer<Endpoint.ResponseType> where Endpoint.ResponseType: UnmarshalingWithContext {
    return ResponseSerializer { data in
        let json = try JSONParser.JSONObjectWithData(data)
        endpoint.log(json)
        let result = try Endpoint.ResponseType.value(from: json, inContext: context)
        guard let typedResult = result as? Endpoint.ResponseType else {
            // Result is identical to T, but of type T.ConvertibleType which Swift can not infer correctly.
            fatalError("error serializing type \(Endpoint.ResponseType.self) with result \(result)")
        }
        return typedResult
    }
}

/// Response serializer to import JSON Array using Marshal and return an array of managed objects
func APICollectionResponseSerializer<Endpoint: APIEndpoint>(_ endpoint: Endpoint, context: Endpoint.ResponseType.Iterator.Element.ContextType) -> DataResponseSerializer<Endpoint.ResponseType> where Endpoint.ResponseType: Collection, Endpoint.ResponseType.Iterator.Element: UnmarshalingWithContext {
    return ResponseSerializer { data in
        let jsonArray = try JSONParser.JSONArrayWithData(data)
        endpoint.log(jsonArray)
        let result = try jsonArray.map({ try Endpoint.ResponseType.Iterator.Element.value(from: $0, inContext: context)})
        guard let typedResult = result as? Endpoint.ResponseType else {
            // Result is identical to T, but of type [T.Iterator.Element] which Swift can not infer correctly.
            fatalError("Unable to transfer typed arrays")
        }
        return typedResult
    }
}
