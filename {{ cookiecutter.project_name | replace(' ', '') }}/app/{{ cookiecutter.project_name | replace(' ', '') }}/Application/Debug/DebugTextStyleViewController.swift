//
//  DebugTextStyleViewController.swift
//  {{ cookiecutter.project_name | replace(' ', '') }}
//
//  Created by {{ cookiecutter.lead_dev }} on 10/25/17.
//  Copyright © 2017 {{ cookiecutter.company_name }}. All rights reserved.
//

import Foundation

import BonMot
import Anchorage

final class DebugTextStyleViewController: UIViewController {

    let textStyles: [(name: String, bonMotStyle: StringStyle)] = [
        ("demo",   .demo),
        ]

    let scrollView = UIScrollView()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Text Styles"
        addBehaviors([ModalDismissBehavior()])

        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.edgeAnchors == view.edgeAnchors
        stackView.topAnchor == scrollView.topAnchor + 80
        stackView.bottomAnchor == scrollView.bottomAnchor
        stackView.horizontalAnchors == horizontalAnchors + 20

        for style in textStyles {
            let label = UILabel()
            label.bonMotStyle = style.bonMotStyle
            label.bonMotStyle?.alignment = .center
            label.numberOfLines = 0
            let font = style.bonMotStyle.font!
            label.styledText = "This is some \(style.name) text! Point size is \(font.pointSize). Font name is \(font.fontName)."
            stackView.addArrangedSubview(label)
        }
    }

}
