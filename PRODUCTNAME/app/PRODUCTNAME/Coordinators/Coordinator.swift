//
//  Coordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import ObjectiveC.runtime

protocol CoordinatorProtocol: class, NSObjectProtocol {
    func attach(to child: AnyObject)
    func detatch(from child: AnyObject)
}

class Coordinator: NSObject, CoordinatorProtocol {}

extension Coordinator {

    private static var key = 0

    func attach(to child: AnyObject) {
        var attached = objc_getAssociatedObject(child, &Coordinator.key) as? NSMutableArray

        if attached == nil {
            attached = NSMutableArray()
            objc_setAssociatedObject(child, &Coordinator.key, attached, .OBJC_ASSOCIATION_RETAIN)
        }

        attached?.add(self)
    }

    func detatch(from child: AnyObject) {
        (objc_getAssociatedObject(child, &Coordinator.key) as? NSMutableArray)?.remove(self)
    }

}
