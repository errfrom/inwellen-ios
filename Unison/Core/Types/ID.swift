//
//  ID.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/17/21.
//  Copyright © 2021 Unison. All rights reserved.
//

enum IDBase: Equatable {
    case int(value: Int)
    case string(value: String)
    case invalid
    
    // - Equatable
    static func == (lhs: IDBase, rhs: IDBase) -> Bool {
        switch (lhs, rhs) {
            case (.invalid, .invalid):
                return false
            
            default:
                return lhs == rhs
        }
    }
    
}

struct ID<T>: Equatable {
    
    let base: IDBase
    
    // - Init
    init(_ base: IDBase) {
        self.base = base
    }
    
    // - Equatable
    static func == <T>(lhs: ID<T>, rhs: ID<T>) -> Bool {
        return lhs.base == rhs.base
    }
    
}

extension ID {
    
    var isValid: Bool {
        return self.base != .invalid
    }
    
    var isInvalid: Bool {
        return self.base == .invalid
    }
    
}
