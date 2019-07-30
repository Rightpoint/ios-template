//
//  TableSection.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on {% now 'utc', '%D' %}.
//  Copyright © {% now 'utc', '%Y' %} {{ cookiecutter.company_name }}. All rights reserved.
//

import UIKit

public class TableSection {
    public var rows: [TableViewCellRepresentable] = []

    public var header: HeaderFooter?
    public var footer: HeaderFooter?
    public init(rows: [TableViewCellRepresentable] = [], header: HeaderFooter? = nil, footer: HeaderFooter? = nil) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
}

extension TableSection {
    public enum HeaderFooter {
        case title(String)
        case view(UIView)

        var title: String? {
            if case .title(let title) = self {
                return title
            }
            return nil
        }
        var view: UIView? {
            if case .view(let view) = self {
                return view
            }
            return nil
        }
    }
}
