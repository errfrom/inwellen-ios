//
//  CircularDoublyLinkedList.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 20.06.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

struct CircularDoublyLinkedList<T> {
    
    // - Data
    private(set) var head: Node?
    private(set) var tail: Node?
    
    // - Node Typealias
    typealias Node = LinkedListNode<T>
    
    // - Node Class
    class LinkedListNode<T> {
        var value: T
        fileprivate(set) var next: LinkedListNode?
        fileprivate(set) var prev: LinkedListNode?
        
        init(with value: T) {
            self.value = value
        }
    }
    
}

// MARK: -
// MARK: - Interface

extension CircularDoublyLinkedList {
    
    /// O(1). Creates a circular doubly linked list containing one value.
    static func singleton(_ newValue: T) -> CircularDoublyLinkedList {
        let newNode = Node(with: newValue)
        var linkedList = CircularDoublyLinkedList()
        
        newNode.next = newNode
        newNode.prev = newNode
        linkedList.head = newNode
        linkedList.tail = newNode
        return linkedList
    }

    /// O(1). Appends a value to the end of the list.
    mutating func append(_ newValue: T) {
        guard head != nil else {
            return self = .singleton(newValue)
        }
        
        let newNode = Node(with: newValue)
        newNode.next = head
        newNode.prev = tail
        head?.prev = newNode
        tail?.next = newNode
        tail = newNode
    }
    
    /// O(1). Removes the first value from the list.
    @discardableResult mutating func removeFirst() -> T? {
        guard head != nil else { return nil }
        
        let removedValue = head?.value
        
        if head === tail {
            self = .init()
            return removedValue
        } else {
            head = head?.next
            head?.prev = tail
            tail?.next = head
            return removedValue
        }
    }
    
    /// O(1). Moves the list head pointer forward to point to the next node.
    @discardableResult mutating func moveHeadForward() -> T? {
        guard head !== tail else { return nil }
        
        tail = head
        head = head?.next
        return head?.value
    }
    
    /// O(1). Moves the list head pointer backward to point to the previous node.
    @discardableResult mutating func moveHeadBackward() -> T? {
        guard head !== tail else { return nil }
        
        head = tail
        tail = tail?.prev
        return tail?.value
    }
    
}
