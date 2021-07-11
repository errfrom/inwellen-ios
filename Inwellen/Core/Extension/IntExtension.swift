//
//  IntExtension.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 10.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

extension Int {

    /// Performs an action *n* times, returning the result of the last one.
    /// - Complexity: O(*n*)
    @discardableResult func times<T>(_ action: () -> T) -> T? {
        guard self > 0 else { return nil }
        for _ in 0..<(self-1) { _ = action() }
        return action()
    }

}
