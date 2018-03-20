//
//  StringStyle+PRODUCTNAME.swft
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 11/1/16.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Foundation
import BonMot

extension StringStyle {

    static let largeTitle: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 34.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let title1: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 28.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let title2: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 22.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let title3: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 20.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let headline: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 17.0,
            weight: .semibold
        )
        style.adaptations = [.control]
        return style
    }()

    static let body: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 17.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let callout: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 16.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let subhead: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 15.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let footnote: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 13.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let caption1: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 12.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

    static let caption2: StringStyle = {
        var style = StringStyle()
        style.font = UIFont.systemFont(
            ofSize: 11.0,
            weight: .regular
        )
        style.adaptations = [.control]
        return style
    }()

}
