//
//  DebugMenuViewController.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Foundation
import Services
import Crashlytics

class DebugMenuViewController: UITableViewController {
    lazy var dataSource: TableDataSource = { [weak self] in
        let dataSource = TableDataSource(rows: [
        SimpleTableCellItem(text: "Text Styles") {
            self?.navigationController?.pushViewController(DebugTextStyleViewController(), animated: true)
        },
        SimpleTableCellItem(text: "Invalidate Refresh Token") {
            APIClient.shared.oauthClient.credentials?.refreshToken = "BAD REFRESH TOKEN"
        },
        SimpleTableCellItem(text: "Invalidate Access Token") {
            APIClient.shared.oauthClient.credentials?.accessToken = "BAD ACCESS TOKEN"
        },
        SimpleTableCellItem(text: "Crash") {
            Crashlytics.sharedInstance().crash()
        },
        SimpleTableCellItem(text: "Logout") {
            APIClient.shared.oauthClient.logout(completion: { (error) in
                NSLog("Logout: \(String(describing: error))")
            })
        },
        ])
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        SimpleTableCellItem.register(tableView)
        tableView.dataSource = dataSource
        addBehaviors([ModalDismissBehavior()])
        var title = "Debug Menu"
        if let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String {
            title.append(" \(version) (\(build))")
        }
        self.title = title
    }
}

extension DebugMenuViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath].performSelection()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
