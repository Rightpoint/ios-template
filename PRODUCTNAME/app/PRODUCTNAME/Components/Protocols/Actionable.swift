//
//  Actionable.swift
//  PRODUCTNAME
//
//  Created by LEADDEVELOPER on 3/8/18.
//  Copyright © 2018 ORGANIZATION. All rights reserved.
//

protocol Actionable: class {
    associatedtype ActionType
    associatedtype Delegate

    func notify(_ action: ActionType)
}

extension Actionable {

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
