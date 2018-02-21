//
//  APIEnvironment.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 7/24/17.
//
//

import Foundation

public enum APIEnvironment {

    case develop
    case sprint
    case production

    static var active: APIEnvironment {
        switch BuildType.active {
        case .debug:        return .develop
        case .internal:     return .sprint
        case .release:      return .production
        }
    }

}

extension APIEnvironment {
    var oathClientToken: String { return "OAUTH_CLIENT_TOKEN_NEEDED" }
    var oathClientID: String { return "OAUTH_CLIENT_ID_NEEDED" }
}
