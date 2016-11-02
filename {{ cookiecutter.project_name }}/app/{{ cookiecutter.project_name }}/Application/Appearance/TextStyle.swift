//
//  TextStyle.swift
//  {{ cookiecutter.project_name }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2016 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation
import BonMot

enum TextStyle: String {
    case navigationTitle = "NavigationTitle"
}

extension TextStyle {
    var stringStyle: StringStyle {
        switch self {
        case .navigationTitle:
            return StringStyle.style(.font(.systemFont(ofSize: 20)))
        }
    }
}
