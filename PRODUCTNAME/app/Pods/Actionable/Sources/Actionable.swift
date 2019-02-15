//
//  Actionable.swift
//  Actionable
//
//  Created by Rightpoint on 2/13/19.
//

import UIKit

public protocol Actionable: class {
    associatedtype ActionType
    associatedtype Delegate

    func notify(_ action: ActionType)
}

public extension Actionable {

    func notify(_ action: ActionType) -> () -> Void {
        return { [weak self] in
            self?.notify(action)
        }
    }

    func notify(_ action: ActionType) -> (UIControl) -> Void {
        return { [weak self] _ in
            self?.notify(action)
        }
    }

    func notify(_ action: ActionType) -> (UIAlertAction) -> Void {
        return { [weak self] _ in
            self?.notify(action)
        }
    }

}
