//
//  ProjectShelfView+Computed.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 3.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import typealias UIKit.CGFloat

// MARK: -
// MARK: - Items

extension ProjectShelfView {

    var headItem: Item? {
        get {
            return items.head?.value
        }
        set {
            guard let newValue = newValue else { return }
            items.head?.value = newValue
        }
    }

    var nextItem: Item? {
        get {
            return items.head?.next?.value
        }
        set {
            guard let newValue = newValue else { return }
            items.head?.next?.value = newValue
        }
    }

    var tailItem: Item? {
        get {
            return items.tail?.value
        }
        set {
            guard let newValue = newValue else { return }
            items.tail?.value = newValue
        }
    }
    
}

// MARK: -
// MARK: - Constants

extension ProjectShelfView {

    var headItemLeadingMargin: CGFloat {
        return headItem?.leadingMargin ?? 0
    }

}
