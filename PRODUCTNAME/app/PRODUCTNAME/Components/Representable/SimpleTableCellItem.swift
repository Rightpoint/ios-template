//
//  SimpleTableCellItem.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Foundation

public struct SimpleTableCellItem {
    public typealias VoidBlock = () -> Void

    let text: String
    let selectCell: VoidBlock

    public init(text: String, selectCell: @escaping VoidBlock) {
        self.text = text
        self.selectCell = selectCell
    }
}

extension SimpleTableCellItem: TableViewCellRepresentable, CellIdentifiable {
    public static func register(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    public func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseIdentifier, for: indexPath)
        cell.textLabel?.text = text
        return cell
    }

    public func performSelection() {
        self.selectCell()
    }
    public func canSelect() -> Bool {
        return true
    }
}
