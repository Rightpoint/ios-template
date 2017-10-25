//
//  TextStyle.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 11/1/16.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation
import BonMot

extension StringStyle {
    // Add all of your pre-defined styles here.
    static var demo: StringStyle {
        return StringStyle(.font(.systemFont(ofSize: 20)))
    }
}
