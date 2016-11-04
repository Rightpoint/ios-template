//
//  Marshal+Date.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/3/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Marshal

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
