//
//  TableDataSource.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import Anchorage

public class TableDataSource: NSObject {
    public var sections: [TableSection] = []

    public init(rows: [TableViewCellRepresentable] = []) {
        super.init()
        append(rows: rows)
    }

    subscript(rows index: Int) -> [TableViewCellRepresentable] {
        get {
            return sections[index].rows
        }
        set(newValue) {
            sections[index].rows = newValue
        }
    }
    public subscript(indexPath: IndexPath) -> TableViewCellRepresentable {
        return sections[indexPath.section].rows[indexPath.row]
    }

    public func append(rows: [TableViewCellRepresentable]) {
        let section = TableSection()
        section.rows = rows
        sections.append(section)
    }

    public func row(at indexPath: IndexPath) -> TableViewCellRepresentable {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row
    }
}

extension TableDataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionRepresentation = sections[section]
        return sectionRepresentation.rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return row(at: indexPath).cell(for: tableView, at: indexPath)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.header?.title
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        return section.header?.view
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = sections[section]
        return section.footer?.title
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = sections[section]
        return section.footer?.view
    }
}
