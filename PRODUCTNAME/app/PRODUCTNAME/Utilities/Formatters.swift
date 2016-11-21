//
//  Formatters.swift
//  PRODUCTNAME
//
//  Created by Brian King on 11/1/16.
//  Copyright © 2016 ORGANIZATION. All rights reserved.
//

import Marshal

protocol DateFormatable {
    func string(from date: Date) -> String

    func date(from string: String) -> Date?
}

extension DateFormatter: DateFormatable {}
@available(iOS 10.0, *)
extension ISO8601DateFormatter: DateFormatable {}

enum Formatters {
    static var ISODateFormatter: DateFormatable {
        let formatter: DateFormatable
        if #available(iOS 10.0, *) {
            formatter = ISO8601DateFormatter()
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            formatter = dateFormatter
        }
        return formatter
    }
}
