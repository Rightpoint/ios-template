//
//  Marshal+Utility.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/3/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Marshal
import KeychainAccess

extension Date : ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        // assuming you have a Date.fromISO8601String implemented...
        guard let date = Formatters.ISODateFormatter.date(from: dateString) else {
            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}

extension Keychain {
    public func getObject<T: Unmarshaling>(_ key: String) throws -> T? {
        guard let data = try getData(key),
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
        }
        let object = try T.init(object: json)
        return object
    }

    public func set<T: Marshaling>(_ value: T, key: String) throws {
        let json = value.marshaled()
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        try set(data, key: key)
    }
}
