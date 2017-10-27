//
//  TableSection.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 6/6/17.
//
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
