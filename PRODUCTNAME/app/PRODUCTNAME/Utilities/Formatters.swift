//
//  Formatters.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
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

    private static var formatters: [String: DateFormatable] = [:]

    private struct Keys {
        static let isoFormatter = "isoFormatter"
    }

    static var ISODateFormatter: DateFormatable {
        if let formatter = formatters[Keys.isoFormatter] {
            return formatter
        }

        if #available(iOS 10.0, *) {
            let isoformatter = ISO8601DateFormatter()
            formatters[Keys.isoFormatter] = isoformatter
            return isoformatter
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            formatters[Keys.isoFormatter] = dateFormatter
            return dateFormatter
        }
    }

}
