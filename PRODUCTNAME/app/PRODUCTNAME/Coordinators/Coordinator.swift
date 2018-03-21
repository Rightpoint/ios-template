//
//  Coordinator.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/24/17.
//  Copyright © 2017 ORGANIZATION. All rights reserved.
//

import ObjectiveC.runtime

class Coordinator: NSObject {}

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
