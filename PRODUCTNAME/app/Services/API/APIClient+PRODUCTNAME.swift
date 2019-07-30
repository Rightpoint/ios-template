//
//  APIClient+PRODUCTNAME.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Foundation

extension APIClient {

    public static var shared = APIClient(baseURL: {
        let baseURL: URL
        switch APIEnvironment.active {
        case .develop:
            baseURL = URL(string: "https://PRODUCTNAME-dev.raizlabs.xyz")!
        case .sprint:
            baseURL = URL(string: "https://PRODUCTNAME-sprint.raizlabs.xyz")!
        case .production:
            fatalError("Specify the release server")
        }
        return baseURL
    }())

}
