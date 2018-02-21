//
//  TableViewCellRepresentable.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 6/6/17.
//
//

import UIKit

public protocol TableViewCellRepresentable: CellIdentifiable {
    static func register(_ tableView: UITableView)

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell

    func canSelect() -> Bool
    func performSelection()
}

public extension TableViewCellRepresentable where Self: ViewRepresentable {
    static func register(_ tableView: UITableView) {
        tableView.register(TableViewContainerCell<View>.self, forCellReuseIdentifier: reuseIdentifier)
    }

    func dequeueConfiguredCell(for tableView: UITableView, at indexPath: IndexPath) -> TableViewContainerCell<View> {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseIdentifier, for: indexPath) as? TableViewContainerCell<View> else {
            fatalError("Wrong cell dequeued from tableView")
        }
        let containedView = cell.containedView ?? makeView()
        if cell.containedView == nil {
            cell.containedView = containedView
        }
        configure(view: containedView)
        return cell
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueConfiguredCell(for: tableView, at: indexPath)
        cell.contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.contentView.preservesSuperviewLayoutMargins = true
        return cell
    }

    func canSelect() -> Bool {
        return true
    }

    func performSelection() {}
}

public protocol CellIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension CellIdentifiable {
    static var reuseIdentifier: String {
        return "Default-\(self)"
    }
}
