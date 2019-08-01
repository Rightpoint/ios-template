//
//  ViewRepresentable.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

public protocol ViewRepresentable: AnyViewRepresentable {
    associatedtype View: UIView
    func makeView() -> View
    func configure(view: View)
}

public extension ViewRepresentable {
    func makeView() -> View {
        return View()
    }
}

public protocol AnyViewRepresentable {
    func initialView() -> UIView
    func update(view: UIView)
}

public extension ViewRepresentable {
    func initialView() -> UIView {
        return makeView()
    }

    func update(view: UIView) {
        guard let typedView = view as? View else {
            fatalError("Expected view of type \(View.self), got \(view)")
        }
        configure(view: typedView)
    }
}

public extension AnyViewRepresentable {
    func makeConfiguredView() -> UIView {
        let view = initialView()
        update(view: view)
        return view
    }
}
