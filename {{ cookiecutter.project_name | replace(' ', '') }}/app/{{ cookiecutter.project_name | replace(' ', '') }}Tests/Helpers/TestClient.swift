//
//  TestClient.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 7/24/17.
//
//

import Foundation
@testable import {{ cookiecutter.project_name | replace(' ', '') }}

enum TestClient {

    static var baseURL: URL {
        return URL(string: "www.google.com/")!
    }

}
