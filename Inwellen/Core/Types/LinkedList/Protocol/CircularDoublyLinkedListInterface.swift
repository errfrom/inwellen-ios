//
//  CircularDoublyLinkedListInterface.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 21.06.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol ICircularDoublyLinkedList: ILinkedList {
    mutating func moveHeadForward() -> NodeValue?
    mutating func moveHeadBackward() -> NodeValue?
}
