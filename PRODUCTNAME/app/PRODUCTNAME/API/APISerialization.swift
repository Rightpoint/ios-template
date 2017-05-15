//
//  APISerialization.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 4/11/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Alamofire
import Marshal

/// Response serializer to import JSON Object using Marshal and return an object
func APIObjectResponseSerializer<T: Unmarshaling>(type: T.Type) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, _, data, error in
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

/// Response serializer to import JSON Array using Marshal and return an array of objects
func APICollectionResponseSerializer<T: Collection>(type: T.Type) -> DataResponseSerializer<T> where T.Iterator.Element: Unmarshaling {
    return DataResponseSerializer { _, _, data, error in
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

/// Response serializer to import JSON Object using Marshal and return a managed object
func APIObjectResponseSerializer<T: UnmarshalingWithContext>(type: T.Type, context: T.ContextType) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, _, data, error in
        do {
            if let error = error { throw error }

            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let object = JSON as? JSONObject else {
                throw APIError.invalidResponse
            }

            let result = try type.value(from: object, inContext: context)
            guard let typedResult = result as? T else {
                // Result is identical to T, but of type T.ConvertibleType which Swift can not infer correctly.
                fatalError("")
            }
            return Result.success(typedResult)
        }
        catch {
            return .failure(error as NSError)
        }
    }
}

/// Response serializer to import JSON Array using Marshal and return an array of managed objects
func APICollectionResponseSerializer<T: Collection>(type: T.Type, context: T.Iterator.Element.ContextType) -> DataResponseSerializer<T> where T.Iterator.Element: UnmarshalingWithContext {
    return DataResponseSerializer { _, _, data, error in
        do {
            if let error = error { throw error }

            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let collection = JSON as? [JSONObject] else {
                throw APIError.invalidResponse
            }
            let result = try collection.map({ try T.Iterator.Element.value(from: $0, inContext: context)})
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
