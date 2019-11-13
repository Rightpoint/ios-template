//
//  Keychain+Codable.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

import KeychainAccess

extension Keychain {
    public func getObject<T: Decodable>(_ key: String) throws -> T? {
        guard let data = try getData(key) else {
                return nil
        }
        let object = try JSONDecoder.default.decode(T.self, from: data)
        return object
    }

    public func set<T: Encodable>(_ value: T, key: String) throws {
        let data = try JSONEncoder.default.encode(value)
        try set(data, key: key)
    }
}
