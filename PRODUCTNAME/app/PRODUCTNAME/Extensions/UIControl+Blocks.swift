//
//  UIControl+Blocks.swift
//  PRODUCTNAME
//
//  Created by Jason Clark on 3/21/18.
//  Copyright © 2018 ORGANIZATION. All rights reserved.
//

import UIKit

public protocol BlockControl: class {}

extension UIControl: BlockControl {}

public extension BlockControl where Self: UIControl {

    /**
     Set a callback to use for an event. Only one callback can be set per event, and multiple
     invocations will remove the previously set callback.

     - parameter event: A UIControlEvents value
     - parameter callback: The event handler callback
     */
    func setCallback(for events: UIControlEvents = .touchUpInside, _ callback: (() -> Void)?) {
        if let callback = callback {
            let target = BlockControlTarget(callback: callback)
            blockTargets[events.rawValue] = target
            addTarget(target, action: #selector(BlockControlTarget.recognized), for: events)
        }
        else {
            clearCallbacks(for: events)
        }
    }

    /**
     Removes the callback registered for the specified events.

     - parameter events: The specific event to clear. If not specified, all registered events are removed.
     - parameter callback: The event handler function
     */
    func clearCallbacks(for events: UIControlEvents? = nil) {
        if let events = events {
            blockTargets.removeValue(forKey: events.rawValue)
        }
        else {
            blockTargets.removeAll()
        }
    }

}

public extension BlockControl where Self: UIButton {

    var callback: (() -> Void)? {
        set {
            setCallback(for: .touchUpInside, newValue)
        }
        get {
            return blockTargets[UIControlEvents.touchUpInside.rawValue]?.callback
        }
    }

}

private class BlockControlTarget {

    let callback: () -> Void

    init(callback: @escaping () -> Void) {
        self.callback = callback
    }

    @objc func recognized() {
        callback()
    }

}

// MARK: Proxy
private var key = "com.raizlabs.blocktarget"

private extension UIControl {

    final var blockTargets: [UInt: BlockControlTarget] {
        get {
            return objc_getAssociatedObject(self, &key) as? [UInt: BlockControlTarget] ?? [:]
        }

        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
