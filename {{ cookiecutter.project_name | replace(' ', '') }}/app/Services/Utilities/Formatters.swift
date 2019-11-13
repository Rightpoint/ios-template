//
//  Formatters.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on TODAYSDATE.
//  Copyright © THISYEAR {{ cookiecutter.company_name }}. All rights reserved.
//

public enum Formatters {

    public static let ISODateFormatter: ISO8601DateFormatter = {
        return ISO8601DateFormatter()
    }()

}
