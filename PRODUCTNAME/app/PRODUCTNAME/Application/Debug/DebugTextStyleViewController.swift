//
//  DebugTextStyleViewController.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 10/25/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import Foundation

import BonMot
import Anchorage

final class DebugTextStyleViewController: UIViewController {

    let textStyles: [(name: String, bonMotStyle: StringStyle)] = [
        ("largeTitle", .largeTitle),
        ("title1", .title1),
        ("title2", .title2),
        ("title3", .title3),
        ("headline", .headline),
        ("body", .body),
        ("callout", .callout),
        ("subhead", .subhead),
        ("footnote", .footnote),
        ("caption1", .caption1),
        ("caption2", .caption2),
        ]

    let scrollView = UIScrollView()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Text Styles"

        view.backgroundColor = Asset.Colors.backgroundPrimary.color

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.edgeAnchors == edgeAnchors
        stackView.verticalAnchors == scrollView.verticalAnchors + 20
        stackView.horizontalAnchors == horizontalAnchors + 20

        for style in textStyles {
            let label = UILabel()
            label.bonMotStyle = style.bonMotStyle
            label.bonMotStyle?.alignment = .left
            label.numberOfLines = 0
            let font = style.bonMotStyle.font!
            label.styledText = "\(style.name)\nPoint size is \(font.pointSize).\nFont name is \(font.fontName)."
            stackView.addArrangedSubview(label)
        }
    }

}
