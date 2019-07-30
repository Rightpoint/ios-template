//
//  ControlContainable.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on TODAYSDATE.
//  Copyright © THISYEAR ORGANIZATION. All rights reserved.
//

import Foundation

final class ControlContainableScrollView: UIScrollView {

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl
            && !(view is UITextInput)
            && !(view is UISlider)
            && !(view is UISwitch) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

}

final class ControlContainableTableView: UITableView {

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl
            && !(view is UITextInput)
            && !(view is UISlider)
            && !(view is UISwitch) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

}

final class ControlContainableCollectionView: UICollectionView {

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl
            && !(view is UITextInput)
            && !(view is UISlider)
            && !(view is UISwitch) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

}
