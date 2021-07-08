//
//  CircularDoublyLinkedListInterface.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 21.06.21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol ICircularDoublyLinkedList: ILinkedList {
    mutating func moveHeadForward() -> NodeValue?
    mutating func moveHeadBackward() -> NodeValue?
}
