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

extension ISO8601DateFormatter: DateFormatable {}

enum Formatters {

    static var ISODateFormatter: DateFormatable = {
        return ISO8601DateFormatter()
    }()

}
