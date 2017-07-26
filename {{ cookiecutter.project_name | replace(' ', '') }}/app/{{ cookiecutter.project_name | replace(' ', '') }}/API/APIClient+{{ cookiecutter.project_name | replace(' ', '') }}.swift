//
//  APIClient+{{ cookiecutter.project_name | replace(' ', '') }}.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 7/24/17.
//
//

import Foundation

extension APIClient {

    static var shared = APIClient(baseURL: {
        let baseURL: URL
        switch APIEnvironment.active {
        case .develop:
            baseURL = URL(string: "https://{{ cookiecutter.project_name | replace(' ', '') }}-dev.raizlabs.xyz")!
        case .sprint:
            baseURL = URL(string: "https://{{ cookiecutter.project_name | replace(' ', '') }}-sprint.raizlabs.xyz")!
        case .production:
            fatalError("Specify the release server")
        }
        return baseURL
    }())

}
