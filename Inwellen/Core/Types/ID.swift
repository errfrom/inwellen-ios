//
//  ID.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/17/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import struct Foundation.UUID

enum IDBase: Equatable {
    case uuid(value: UUID)
    case int(value: Int)
    case invalid
    
    // - Equatable
    static func == (lhs: IDBase, rhs: IDBase) -> Bool {
        switch (lhs, rhs) {
            case (.invalid, .invalid):
                return false
            
            case (.uuid(let lvalue), .uuid(let rvalue)):
                return lvalue == rvalue

            case (.int(let lvalue), .int(let rvalue)):
                return lvalue == rvalue

            default:
                return false
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
