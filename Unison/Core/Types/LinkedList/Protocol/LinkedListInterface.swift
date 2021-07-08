//
//  LinkedListInterface.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 21.06.21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol ILinkedList {
    associatedtype NodeValue
    
    static func singleton(_ newValue: NodeValue) -> Self
    mutating func append(_ newValue: NodeValue)
    mutating func removeFirst() -> NodeValue?
}
