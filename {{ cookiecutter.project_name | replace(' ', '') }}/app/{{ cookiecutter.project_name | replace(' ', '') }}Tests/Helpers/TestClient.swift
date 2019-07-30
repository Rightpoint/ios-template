//
//  TestClient.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation
@testable import {{ cookiecutter.project_name | replace(' ', '') }}

enum TestClient {

    static var baseURL: URL {
        return URL(string: "https://google.com")!
    }

}
